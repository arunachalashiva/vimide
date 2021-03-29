from distutils.sysconfig import get_python_inc
import os
import platform
import os.path as p
import subprocess

DIR_OF_THIS_SCRIPT = p.abspath(p.dirname(__file__))
DIR_OF_THIRD_PARTY = p.join(DIR_OF_THIS_SCRIPT, 'third_party')
SOURCE_EXTENSIONS = ['.cpp', '.cxx', '.cc', '.c', '.m', '.mm']
PATH_TO_LOMBOK = "/usr/local/share/vim/lombok-1.18.8-sources.jar"

database = None

# These are the compilation flags that will be used in case there's no
# compilation database set (by default, one is not set).
# CHANGE THIS LIST OF FLAGS. YES, THIS IS THE DROID YOU HAVE BEEN LOOKING FOR.
flags = [
    '-Wall',
    '-Wextra',
    '-Werror',
    '-Wno-long-long',
    '-Wno-variadic-macros',
    '-fexceptions',
    '-DNDEBUG',
    # You 100% do NOT need -DUSE_CLANG_COMPLETER and/or -DYCM_EXPORT in your flags;
    # only the YCM source code needs it.
    '-DUSE_CLANG_COMPLETER',
    '-DYCM_EXPORT=',
    # THIS IS IMPORTANT! Without the '-x' flag, Clang won't know which language to
    # use when compiling headers. So it will guess. Badly. So C++ headers will be
    # compiled as C headers. You don't want that so ALWAYS specify the '-x' flag.
    # For a C project, you would set this to 'c' instead of 'c++'.
    '-x',
    'c++',
    '-isystem',
    'cpp/pybind11',
    '-isystem',
    'cpp/whereami',
    '-isystem',
    'cpp/BoostParts',
    '-isystem',
    get_python_inc(),
    '-isystem',
    'cpp/llvm/include',
    '-isystem',
    'cpp/llvm/tools/clang/include',
    '-I',
    'cpp/ycm',
    '-I',
    'cpp/ycm/ClangCompleter',
    '-isystem',
    'cpp/ycm/tests/gmock/gtest',
    '-isystem',
    'cpp/ycm/tests/gmock/gtest/include',
    '-isystem',
    'cpp/ycm/tests/gmock',
    '-isystem',
    'cpp/ycm/tests/gmock/include',
    '-isystem',
    'cpp/ycm/benchmarks/benchmark/include',
]

# Clang automatically sets the '-std=' flag to 'c++14' for MSVC 2015 or later,
# which is required for compiling the standard library, and to 'c++11' for older
# versions.
if platform.system() != 'Windows':
    flags.append('-std=c++11')


# Set this to the absolute path to the folder (NOT the file!) containing the
# compile_commands.json file to use that instead of 'flags'. See here for
# more details: http://clang.llvm.org/docs/JSONCompilationDatabase.html
#
# You can get CMake to generate this file for you by adding:
#   set( CMAKE_EXPORT_COMPILE_COMMANDS 1 )
# to your CMakeLists.txt file.
#
# Most projects will NOT need to set this to anything; you can just change the
# 'flags' list of compilation flags. Notice that YCM itself uses that approach.
compilation_database_folder = ''


def IsHeaderFile(filename):
    extension = p.splitext(filename)[1]
    return extension in ['.h', '.hxx', '.hpp', '.hh']


def FindCorrespondingSourceFile(filename):
    if IsHeaderFile(filename):
        basename = p.splitext(filename)[0]
        for extension in SOURCE_EXTENSIONS:
            replacement_file = basename + extension
            if p.exists(replacement_file):
                return replacement_file
    return filename


def PathToPythonUsedDuringBuild():
    try:
        filepath = p.join(DIR_OF_THIS_SCRIPT, 'PYTHON_USED_DURING_BUILDING')
        with open(filepath) as f:
            return f.read().strip()
    except OSError:
        return None


def Settings(**kwargs):
    # Do NOT import ycm_core at module scope.
    import ycm_core

    global database
    if database is None and p.exists(compilation_database_folder):
        database = ycm_core.CompilationDatabase(compilation_database_folder)

    language = kwargs['language']

    if language == 'cfamily':
        # If the file is a header, try to find the corresponding source file and
        # retrieve its flags from the compilation database if using one. This is
        # necessary since compilation databases don't have entries for header files.
        # In addition, use this source file as the translation unit. This makes it
        # possible to jump from a declaration in the header file to its definition
        # in the corresponding source file.
        filename = FindCorrespondingSourceFile(kwargs['filename'])

        if not database:
            return {
                'flags': flags,
                'include_paths_relative_to_dir': DIR_OF_THIS_SCRIPT,
                'override_filename': filename
            }

        compilation_info = database.GetCompilationInfoForFile(filename)
        if not compilation_info.compiler_flags_:
            return {}

        # Bear in mind that compilation_info.compiler_flags_ does NOT return a
        # python list, but a "list-like" StringVec object.
        final_flags = list(compilation_info.compiler_flags_)

        # NOTE: This is just for YouCompleteMe; it's highly likely that your project
        # does NOT need to remove the stdlib flag. DO NOT USE THIS IN YOUR
        # ycm_extra_conf IF YOU'RE NOT 100% SURE YOU NEED IT.
        try:
            final_flags.remove('-stdlib=libc++')
        except ValueError:
            pass

        return {
            'flags': final_flags,
            'include_paths_relative_to_dir': compilation_info.compiler_working_dir_,
            'override_filename': filename
        }

    if language == 'python':
        return {
            'interpreter_path': PathToPythonUsedDuringBuild()
        }

    if language == 'java':
        if not os.path.exists( PATH_TO_LOMBOK ):
            raise RuntimeError( "Didn't find lombok jar!" )
        return {
            'ls': {
                'java.format.onType.enabled': True
            }
            #'jvm': {
            #    'args': [ '-javaagent:' + PATH_TO_LOMBOK,
            #    '-Xbootclasspath/a:' + PATH_TO_LOMBOK ]
            #}
        }

    return {}


def PythonSysPath(**kwargs):
    sys_path = kwargs['sys_path']

    interpreter_path = kwargs['interpreter_path']
    major_version = subprocess.check_output([
        interpreter_path, '-c', 'import sys; print( sys.version_info[ 0 ] )']
    ).rstrip().decode('utf8')

    sys_path[0:0] = [p.join(DIR_OF_THIS_SCRIPT),
                     p.join(DIR_OF_THIRD_PARTY, 'bottle'),
                     p.join(DIR_OF_THIRD_PARTY, 'cregex',
                            'regex_{}'.format(major_version)),
                     p.join(DIR_OF_THIRD_PARTY, 'frozendict'),
                     p.join(DIR_OF_THIRD_PARTY, 'jedi_deps', 'jedi'),
                     p.join(DIR_OF_THIRD_PARTY, 'jedi_deps', 'parso'),
                     p.join(DIR_OF_THIRD_PARTY, 'requests_deps', 'requests'),
                     p.join(DIR_OF_THIRD_PARTY, 'requests_deps',
                            'urllib3',
                            'src'),
                     p.join(DIR_OF_THIRD_PARTY, 'requests_deps',
                            'chardet'),
                     p.join(DIR_OF_THIRD_PARTY, 'requests_deps',
                            'certifi'),
                     p.join(DIR_OF_THIRD_PARTY, 'requests_deps',
                            'idna'),
                     p.join(DIR_OF_THIRD_PARTY, 'waitress')]

    sys_path.append(p.join(DIR_OF_THIRD_PARTY, 'jedi_deps', 'numpydoc'))
    return sys_path
