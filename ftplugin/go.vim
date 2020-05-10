setlocal tabstop=4
setlocal shiftwidth=4

" ALE settings
let b:ale_linters = {'go': ['gopls', 'gofmt']}
let b:ale_fixers = {'go': ['gofmt', 'goimports', 'trim_whitespace', 'remove_trailing_lines']}
