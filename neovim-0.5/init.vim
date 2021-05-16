call plug#begin("~/.vim/plugged")

" nvim lsp
Plug 'neovim/nvim-lspconfig'

" auto completion for lsp
Plug 'nvim-lua/completion-nvim'

" Fomatter
Plug 'mhartington/formatter.nvim'

" Nerd tree
Plug 'scrooloose/nerdtree'
Plug 'xuyuanp/nerdtree-git-plugin'

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
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" fzf for lsp
Plug 'ojroques/nvim-lspfuzzy', {'branch': 'main'}

" Solarized color scheme
Plug 'altercation/vim-colors-solarized'

" Onedark color scheme
Plug 'joshdick/onedark.vim'

" My own plugin for maven commands
Plug 'arunachalashiva/mvndisp'

call plug#end()

filetype plugin on

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

" Setup fzf for lsp results
lua require('lspfuzzy').setup {}

" Registered language servers
lua require'lspconfig'.pyls.setup{on_attach=require'completion'.on_attach}
lua require'lspconfig'.gopls.setup{on_attach=require'completion'.on_attach}
lua require'lspconfig'.jdtls.setup{cmd={'jdt'},on_attach=require'completion'.on_attach}
lua require'lspconfig'.clangd.setup{on_attach=require'completion'.on_attach}
lua require'lspconfig'.bashls.setup{on_attach=require'completion'.on_attach}
lua require'lspconfig'.yamlls.setup{on_attach=require'completion'.on_attach}

" Auto format setting
autocmd BufWritePre *.py lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.sh lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.{yml,yaml} lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.{c,cpp} lua vim.lsp.buf.formatting_sync(nil, 100)
" autocmd BufWritePre *.java lua vim.lsp.buf.formatting_sync(nil, 100)

lua << EOF
require('formatter').setup({
  filetype = {
    java = {
      function()
        return {
          exe = 'java',
          args = {'-jar', '/usr/local/share/vim/google-java-format-1.6-all-deps.jar', vim.api.nvim_buf_get_name(0)},
          stdin = true
        }
      end
    }
  }
})

vim.api.nvim_exec([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.java FormatWrite
augroup END
]], true)
EOF

" LSP config
nnoremap <silent> <Leader>gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <Leader>gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> <Leader>gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> <Leader>gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <Leader>rn <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <Leader>ho <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <Leader>sh <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <Leader>dp <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> <Leader>dn <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <silent> <Leader>ca <cmd>lua vim.lsp.buf.code_action()<CR>

" Airline settings
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#nvimlsp#enabled = 1
let g:airline#extensions#nvimlsp#error_symbol = 'E:'
let g:airline#extensions#nvimlsp#warning_symbol = 'W:'

" fzf settings
let g:fzf_tags_command = 'ctags -R'
" let g:fzf_layout = { 'window': 'enew' }
 command! -bang -nargs=* Rg
   \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>),
   \ 1, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%'), <bang>0)

let g:NERDSpaceDelims = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDTreeMinimalUI = 1

let $JAVA_TOOL_OPTIONS = '-javaagent:/usr/local/share/vim/lombok-1.18.8.jar'
let g:mvndisp_mvn_cmd = 'unset JAVA_TOOL_OPTIONS && mvn '

" nerdtree short cut to toggle open/close
nnoremap <silent> <expr> <Leader>nt g:NERDTree.IsOpen() ?
                        \ "\:NERDTreeClose<CR>" : bufexists(expand('%')) ?
                        \ "\:NERDTreeFind<CR>" : "\:NERDTree<CR>"

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

silent! colorscheme onedark

" Open file from last location
if has("autocmd")
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" add yaml stuffs
autocmd! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

autocmd FileType java setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType cpp setlocal ts=2 sts=2 sw=2 expandtab

set encoding=utf-8
set switchbuf=usetab
set tabline=[%t]
set cursorline cursorcolumn
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
  exe ':vsp term://zsh'
endfun

" Run Rg search for current word under cursor
fun! SearchWd()
  let l:str = expand('<cword>') . '**'
  exe ':Rg ' . l:str
endfun

" Command to change to a directory (also refreshes NERDTree)
command! -nargs=1 -complete=dir OpenProject :call OpenProject(<q-args>)
command! -nargs=0 FindWord :call SearchWd()
command! -nargs=0 OpenTerminal :call OpenTerm()
