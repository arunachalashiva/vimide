call plug#begin("~/.vim/plugged")

" nvim lsp
Plug 'neovim/nvim-lspconfig'

" auto completion for lsp
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

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

" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Onedark color scheme
Plug 'joshdick/onedark.vim'

" My own plugin for maven commands
Plug 'arunachalashiva/mvndisp'

call plug#end()

filetype plugin on

let g:NVIM_DATA = $HOME . '/data/'
let g:NVIM_JDT_WS = g:NVIM_DATA . 'workspace/'

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Avoid showing message extra message when using completion
set shortmess+=c

set completeopt=menu,menuone,noselect

lua << EOF
local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = {
    {name = 'nvim_lsp'}
  }
})
local cap = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Registered language servers
require'lspconfig'.jdtls.setup{cmd={'jdt', vim.api.nvim_eval("g:NVIM_JDT_WS")..vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')},capabilities=cap}
require'lspconfig'.pylsp.setup{capabilities=cap}
require'lspconfig'.gopls.setup{capabilities=cap}
require'lspconfig'.clangd.setup{capabilities=cap}
require'lspconfig'.bashls.setup{capabilities=cap}
require'lspconfig'.yamlls.setup{capabilities=cap}
EOF

" Auto format setting
autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.sh lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.{yml,yaml} lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.{c,cpp} lua vim.lsp.buf.formatting_sync(nil, 100)

lua << EOF
require('formatter').setup({
  filetype = {
    java = {
      function()
        return {
          exe = 'java',
          args = {'-jar', vim.api.nvim_eval("g:NVIM_DATA")..'/google-java-format-1.6-all-deps.jar', vim.api.nvim_buf_get_name(0)},
          stdin = true
        }
      end
    },
    python = {
      function()
        return {
          exe = 'yapf',
          stdin = true
        }
      end
    }
  }
})

vim.api.nvim_exec([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.py,*.java FormatWrite
augroup END
]], true)
EOF

" LSP config
nnoremap <silent> <Leader>gd <cmd>lua require('telescope.builtin').lsp_definitions()<CR>
nnoremap <silent> <Leader>gD <cmd>lua require('telescope.builtin').lsp_type_definitions()<CR>
nnoremap <silent> <Leader>gr <cmd>lua require('telescope.builtin').lsp_references()<CR>
nnoremap <silent> <Leader>gi <cmd>lua require('telescope.builtin').lsp_implementations()<CR>
nnoremap <silent> <Leader>ca <cmd>lua require('telescope.builtin').lsp_code_actions()<CR>
nnoremap <silent> <Leader>dd <cmd>lua require('telescope.builtin').lsp_document_diagnostics()<CR>
nnoremap <silent> <Leader>dw <cmd>lua require('telescope.builtin').lsp_workspace_diagnostics()<CR>
nnoremap <silent> <Leader>rn <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <Leader>ho <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <Leader>sh <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <Leader>dp <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> <Leader>dn <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <silent> <Leader>wa <cmd>lua vim.lsp.buf.add_workspace_folder()<CR>
nnoremap <silent> <Leader>wl <cmd>lua vim.lsp.buf.list_workspace_folders()<CR>

" Airline settings
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#nvimlsp#enabled = 1
let g:airline#extensions#nvimlsp#error_symbol = 'E:'
let g:airline#extensions#nvimlsp#warning_symbol = 'W:'

let g:NERDSpaceDelims = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDTreeMinimalUI = 1

let $JAVA_TOOL_OPTIONS = '-javaagent:' . g:NVIM_DATA . '/lombok-1.18.8.jar'
let g:mvndisp_mvn_cmd = 'unset JAVA_TOOL_OPTIONS && mvn '

" nerdtree short cut to toggle open/close
nnoremap <silent> <expr> <Leader>nt g:NERDTree.IsOpen() ?
                        \ "\:NERDTreeClose<CR>" : bufexists(expand('%')) ?
                        \ "\:NERDTreeFind<CR>" : "\:NERDTree<CR>"

" fzf shortcuts for files and tags
nnoremap <silent> <Leader>ff <cmd>lua require('telescope.builtin').find_files()<CR>
nnoremap <silent> <Leader>fg <cmd>lua require('telescope.builtin').live_grep()<CR>
nnoremap <silent> <Leader>fw <cmd>lua require('telescope.builtin').grep_string()<CR>

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

" Command to change to a directory (also refreshes NERDTree)
command! -nargs=1 -complete=dir OpenProject :call OpenProject(<q-args>)
command! -nargs=0 OpenTerminal :call OpenTerm()
