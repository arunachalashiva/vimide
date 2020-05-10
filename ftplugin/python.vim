setlocal tabstop=4
setlocal shiftwidth=4
setlocal expandtab

" pip install jedi, flake8, autopep8 globally for python

" ALE settings
let b:ale_linters = {'python': ['flake8']}
let b:ale_fixers = {'python': ['yapf', 'autopep8', 'isort', 'trim_whitespace', 'remove_trailing_lines']}
let b:ale_python_flake8_executable = 'flake8'
let b:ale_python_flake8_use_global = 1
let b:ale_use_global_executables = 1

" YCM settings
let b:ycm_server_python_interpreter = '/usr/bin/python3'
let b:ale_python_flake8_options = '--ignore=E501'
let b:ale_set_baloons = 1
