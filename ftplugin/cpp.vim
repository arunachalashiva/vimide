setlocal tabstop=4
setlocal shiftwidth=4
" setlocal expandtab

" apt-get install install clang, clangd, clang-tidy, clang-format

" ALE Settings
let b:ale_use_global_executables = 1
let b:ale_linters = {'cpp': ['clangtidy']}
let b:ale_fixers = {'cpp': ['clang-format', 'clangtidy', 'trim_whitespace', 'remove_trailing_lines']}
let b:ale_cpp_clangtidy_options = '-Wall -Wextra -Werror -std=c++11 -x c++ -I . -I src/ -I include/ -I /usr/include/c++/7 -I /usr/local/include/'
let b:ale_cpp_clangtidy_checks = ['clang-analyzer-*', 'llvm-*', 'cppcoreguidelines-*', 'google-*']
let b:ale_cpp_clangtidy_fix_errors = 1
let b:ale_cpp_clangformat_options = '-sort-includes -style="{BasedOnStyle: google}"'

" update tags automatically
let b:auto_ctags = 1

" YCM settings
let b:ycm_use_clangd = 1
let b:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let b:ycm_clangd_uses_ycmd_caching = 0
let b:ycm_clangd_binary_path = exepath("clangd")
let b:ycm_clangd_args = ['-log=verbose', '-pretty']
