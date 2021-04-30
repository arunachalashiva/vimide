call plug#begin('~/.vim/plugged')

" Install YouCompleteMe
Plug 'Valloric/YouCompleteMe'


" Nerdtree plugin
Plug 'scrooloose/nerdtree'
Plug 'xuyuanp/nerdtree-git-plugin'

" Nerdcommenter plugin
Plug 'scrooloose/nerdcommenter'

" ALE lint plugin
Plug 'w0rp/ale'

" Vim-Airline plugin
Plug 'vim-airline/vim-airline'

" Vim-Airline theme plugin
Plug 'vim-airline/vim-airline-themes'

" Vim-fugitive git plugin
Plug 'tpope/vim-fugitive'

" Show git diff in gutter
Plug 'airblade/vim-gitgutter'

" Vim-Dispatch plugin
Plug 'tpope/vim-dispatch'

" fzf
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Solarized color scheme
Plug 'altercation/vim-colors-solarized'

" Onedark color scheme
Plug 'joshdick/onedark.vim'

" Auto ctags update on file change
Plug 'soramugi/auto-ctags.vim'

Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'


" My own plugin
Plug 'arunachalashiva/mvndisp'

call plug#end()

filetype plugin on

nnoremap <Leader>h :HelpVimide<CR>

" nerdtree short cut to toggle open/close
nnoremap <silent> <expr> <Leader>nt g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>"

" fzf shortcuts for files and tags
nnoremap <silent> <Leader>ff :call FzfFiles()<CR>
nnoremap <silent> <Leader>ft :call FzfTags()<CR>
nnoremap <silent> <Leader>fg :call FzfRg()<CR>
nnoremap <silent> <Leader>fw :FindWord<CR>

nnoremap <silent> <C-Right> :call BufferNext()<CR>
nnoremap <silent> <C-Left> :call BufferPrevious()<CR>

nnoremap <Leader>op :OpenProject 
nnoremap <Leader>ot :OpenTerminal<CR>
nnoremap <Leader>bd :bdelete<CR>
nnoremap <Leader>om :Dispatch grip -b %<CR>

nnoremap <Leader>af :ALEFix<CR>
nnoremap <Leader>yf :YcmCompleter FixIt<CR>
nnoremap <Leader>yr :YcmCompleter GoToReferences<CR>
nnoremap <Leader>yd :YcmCompleter GetDoc<CR>
nnoremap <Leader>yt :YcmCompleter GetType<CR>
nnoremap <Leader>yg :YcmCompleter GoTo<CR>

" Airline settings
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#ycm#enabled = 1
let g:airline#extensions#ycm#error_symbol = 'E:'
let g:airline#extensions#ycm#warning_symbol = 'W:'

" fzf settings
let g:fzf_tags_command = 'ctags -R'
let g:fzf_layout = { 'window': 'enew' }

let g:NERDSpaceDelims = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDTreeMinimalUI=1

" auto-ctags settings
let g:auto_ctags = 1
let g:auto_ctags_tags_args = ['--tag-relative=yes', '--recurse=yes', '--sort=yes']
let g:auto_ctags_filetype_mode = 1
let g:auto_ctags_set_tags_option = 1
let g:auto_ctags_warn_once = 1

" YCM settings
let g:ycm_log_level = 'debug'
let g:ycm_keep_logfiles = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_filetype_blacklist = { 'nerdtree': 1 }
let g:ycm_semantic_triggers =  {
  \   'c' : ['->', '.','re![_a-zA-z0-9]'],
  \   'objc' : ['->', '.', 're!\[[_a-zA-Z]+\w*\s', 're!^\s*[^\W\d]\w*\s',
  \             're!\[.*\]\s'],
  \   'ocaml' : ['.', '#'],
  \   'cpp,objcpp' : ['->', '.', '::','re![_a-zA-Z0-9]'],
  \   'perl' : ['->'],
  \   'php' : ['->', '::'],
  \   'cs,java,javascript,typescript,d,python,perl6,scala,vb,elixir,go' : ['.'],
  \   'ruby' : ['.', '::'],
  \   'lua' : ['.', ':'],
  \   'erlang' : [':'],
  \ }

"lombok work around for youcompleteme
let $JAVA_TOOL_OPTIONS = '-javaagent:/usr/local/share/vim/lombok-1.18.8.jar'
" let $JAVA_TOOL_OPTIONS = '-javaagent:/usr/local/share/vim/lombok-1.18.8.jar -Xbootclasspath/a:/usr/local/share/vim/lombok-1.18.8.jar'

" Settings for my plugin mvndiskp
" Need to unset the above set JAVA_TOOL_OPTIONS (lombok work around) for mvn
" to work.
let g:mvndisp_mvn_cmd = 'unset JAVA_TOOL_OPTIONS && mvn '

" Color Schemes
let g:solarized_termcolors = 256
set background=dark
silent! colorscheme solarized
silent! call togglebg#map("<F5>")
silent! colorscheme onedark

" Open file from last location
if has("autocmd")
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" add yaml stuffs
autocmd! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

set encoding=utf-8
set switchbuf=usetab
set tabline=[%t]
set cursorline
set number
set incsearch
set ignorecase smartcase
set expandtab smarttab

" set spell

" Disable fzf shortcuts in nerdtree buffer
fun! FzfFiles()
  if &filetype != "nerdtree"
    exe ':Files'
  endif
endfun

fun! FzfTags()
  if &filetype != "nerdtree"
    exe ':Tags'
  endif
endfun

fun! FzfRg()
  if &filetype != "nerdtree"
    exe ':Rg'
  endif
endfun

" Disable buf next and previous shortcut in nerdtree
fun! BufferNext()
  if &filetype != "nerdtree"
    exe ':bnext'
  endif
endfun

fun! BufferPrevious()
  if &filetype != "nerdtree"
    exe ':bprevious'
  endif
endfun

" Change directory and refresh nerdtree
fun! OpenProject(dir)
  exe ':cd ' . a:dir
  exe ':bufdo bwipeout'
  exe ':NERDTreeCWD'
endfun

" Open bash terminal
fun! OpenTerm()
  exe ':terminal ++rows=10 bash'
endfun

" Run Rg search for current word under cursor
fun! SearchWd()
  let l:str = expand('<cword>') . '**'
  exe ':Rg ' . l:str
endfun

fun! MyHelp()
  echom("vimide shortcuts")
  echom("'\\h'  - Display this help")
  echom("'<ctrl-Left>'  - Switch to previous buffer")
  echom("'<ctrl-Right>' - Switch to next buffer")
  echom("'\\bd' - buffer delete - Deletes current buffer")
  echom("'\\nt' - nerdtree toggle - Open/Close NERDTree")
  echom("'\\ff' - find files - Open fzf Files")
  echom("'\\ft' - find tags - Open fzf Tags")
  echom("'\\fg' - find grep pattern - Open fzf Rg (grep)")
  echom("'\\fw' - find grep pattern for current word under cursor using Rg")
  echom("'\\af' - Run ALEFix (fixer for lint errors)")
  echom("'\\yf' - Run YouCompleteMe FixIt")
  echom("'\\yr' - List References - YouCompleteMe GoToReferences")
  echom("'\\yd' - GotTo Documentation - YouCompleteMe GetDoc")
  echom("'\\yt' - GetType - YouCompleteMe GetType")
  echom("'\\yg' - Go to definition - YouCompleteMe GoTo - <ctrl-o> to go back")
  echom("'\\op' - Open Project - Calls OpenProject <dir> directory and refresh NERDTree")
  echom("'\\ot' - Open Terminal - Opens a bash terminal")
  echom("'\\om' - Open Markdown preview in chrome")
  echom("'\\mas' - Run :MvnCompile all (entire project)")
  echom("'\\mat' - Run :MvnTest all (entire project)")
  echom("'\\mms' - Run :MvnCompile submodule")
  echom("'\\mmt' - Run :MvnTest module (current submodule)")
  echom("'\\mtt' - Run :MvnTest this (current test file)")
  echom("'\\mca' - Run :MvnClean all (entire project)")
  echom("'\\mcm' - Run :MvnClean module (current submodule)")
  echom("")
  echom("vimide commands")
  echom("':OpenProject <dir>' - Switch to <dir> directory and refresh NERDTree")
endfun

" Command to change to a directory (also refreshes NERDTree)
command! -nargs=1 -complete=dir OpenProject :call OpenProject(<q-args>)
command! -nargs=0 HelpVimide :call MyHelp()
command! -nargs=0 FindWord :call SearchWd()
command! -nargs=0 OpenTerminal :call OpenTerm()

" Ignore filename if Rg search
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)

"set mouse=a
"set ttymouse=sgr

" Current date
nnoremap <F6> "=strftime("%c")<CR>P
