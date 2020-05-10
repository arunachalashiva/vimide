setlocal tabstop=2
setlocal shiftwidth=2
setlocal expandtab

let b:java_highlight_java_lang_ids = 1
let b:java_highlight_all = 1
let b:java_mark_braces_in_parens_as_errors = 1

" ALE linters and fixers
let b:ale_linters = {'java': ['checkstyle']}
let b:ale_fixers = {'java': ['google_java_format']}
let b:ale_java_checkstyle_options = '-c /usr/local/share/vim/google_checks.xml'

" update tags automatically
let b:auto_ctags = 1

" YCM settings
let b:ycm_collect_identifiers_from_tags_files = 1
let b:ycm_always_populate_location_list = 1

" Short cuts to mvndisp plugin
nnoremap <Leader>mat :MvnTest all<CR>
nnoremap <Leader>mas :MvnCompile all<CR>
nnoremap <Leader>mmt :MvnTest module<CR>
nnoremap <Leader>mms :MvnCompile module<CR>
nnoremap <Leader>mtt :MvnTest this<CR>
nnoremap <Leader>mca :MvnClean all<CR>
nnoremap <Leader>mcm :MvnClean module<CR>
