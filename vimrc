set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/.fzf
call vundle#begin()

" Vundle to manage vundle
Plugin 'VundleVim/Vundle.vim'

" Install YouCompleteMe
Plugin 'Valloric/YouCompleteMe'

" Nerdtree plugin
Plugin 'scrooloose/nerdtree'
Plugin 'xuyuanp/nerdtree-git-plugin'

" Nerdcommenter plugin
Plugin 'scrooloose/nerdcommenter'

" ALE lint plugin
Plugin 'w0rp/ale'

" Vim-Airline plugin
Plugin 'vim-airline/vim-airline'

" Vim-Airline theme plugin
Plugin 'vim-airline/vim-airline-themes'

" Vim-fugitive git plugin
Plugin 'tpope/vim-fugitive'

" Show git diff in gutter
Plugin 'airblade/vim-gitgutter'

" Vim-Dispatch plugin
Plugin 'tpope/vim-dispatch'

" Docker file plugin
Plugin 'ekalinin/Dockerfile.vim'

" fzf
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'

" Distraction free mode
Plugin 'junegunn/goyo.vim'

" Solarized color scheme
Plugin 'altercation/vim-colors-solarized'

" Onedark color scheme
Plugin 'joshdick/onedark.vim'

" Auto ctags update on file change
Plugin 'soramugi/auto-ctags.vim'

" My own plugin
Plugin 'arunachalashiva/mvndisp'

call vundle#end()
filetype plugin indent on
syntax on

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
nnoremap <Leader>bd :bdelete<CR>

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

" YCM settings
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
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
" lombok work around for youcompleteme
let $JAVA_TOOL_OPTIONS = '-javaagent:/usr/local/share/vim/lombok-1.18.8.jar -Xbootclasspath/p:/usr/local/share/vim/lombok-1.18.8-sources.jar'

" Instant markdown settings
let g:instant_markdown_logfile = '/tmp/instant_markdown.log'
let g:instant_markdown_slow = 1
let g:instant_markdown_browser = "firefox --new-window"

" Settings for my plugin mvndiskp
" Need to unset the above set JAVA_TOOL_OPTIONS (lombok work around) for mvn
" to work.
let g:mvndisp_mvn_cmd = 'unset JAVA_TOOL_OPTIONS && mvn'

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

set mouse=a
set ttymouse=sgr