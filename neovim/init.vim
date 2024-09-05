call plug#begin("~/.nvim/plugged")

" nvim lsp
Plug 'neovim/nvim-lspconfig'

" auto completion for lsp
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" Fomatter
Plug 'mhartington/formatter.nvim'
Plug 'lukas-reineke/lsp-format.nvim'

" Vim-Airline plugin
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Git plugins
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'APZelos/blamer.nvim'

" Vim-Dispatch plugin
Plug 'tpope/vim-dispatch'

" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Onedark color scheme
Plug 'joshdick/onedark.vim'

" My own plugin for maven commands
Plug 'arunachalashiva/mvndisp'

Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'

" Code commenting - use 'gcc' or 'gcb'
Plug 'numToStr/Comment.nvim'

" flutter tools
Plug 'akinsho/flutter-tools.nvim'

" Java
Plug 'mfussenegger/nvim-jdtls'

" Startup
Plug 'nvimdev/dashboard-nvim'

Plug 'hedyhli/outline.nvim'

call plug#end()

filetype plugin on

"-- disable netrw at the very start of your init.lua (strongly advised)
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

let g:NVIM_DATA = $HOME . '/data/'

let g:NVIM_LOMBOK = '-javaagent:' . g:NVIM_DATA . 'lombok-1.18.26.jar'
let g:mvndisp_mvn_cmd = 'mvn '

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Avoid showing message extra message when using completion
set shortmess+=c
set completeopt=menu,menuone,noselect

" LSP config
nnoremap <silent> <Leader>gd <cmd>lua require('telescope.builtin').lsp_definitions()<CR>
nnoremap <silent> <Leader>gD <cmd>lua require('telescope.builtin').lsp_type_definitions()<CR>
nnoremap <silent> <Leader>gr <cmd>lua require('telescope.builtin').lsp_references({show_line = false})<CR>
nnoremap <silent> <Leader>gi <cmd>lua require('telescope.builtin').lsp_implementations()<CR>
nnoremap <silent> <Leader>ca <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> <Leader>rn <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <Leader>ho <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <Leader>sh <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <Leader>dd <cmd>lua require('telescope.builtin').diagnostics()<CR>
nnoremap <silent> <Leader>dp <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> <Leader>dn <cmd>lua vim.diagnostic.goto_next()<CR>
nnoremap <silent> <Leader>wa <cmd>lua vim.lsp.buf.add_workspace_folder()<CR>
nnoremap <silent> <Leader>wl <cmd>lua vim.lsp.buf.list_workspace_folders()<CR>

" Airline settings
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#nvimlsp#enabled = 1
let g:airline#extensions#nvimlsp#error_symbol = 'E:'
let g:airline#extensions#nvimlsp#warning_symbol = 'W:'


" nvimtree short cut to toggle open/close
nnoremap <silent> <expr> <Leader>nt bufexists(expand('%')) ?
                        \ "\:NvimTreeFindFileToggle<CR>" : "\:NvimTreeToggle<CR>"

" Enable Git Blamer
let g:blamer_enabled = 1

" telescope shortcuts for files and tags
nnoremap <silent> <Leader>ff <cmd>lua require('telescope.builtin').find_files()<CR>
nnoremap <silent> <Leader>fg <cmd>lua require('telescope.builtin').live_grep()<CR>
nnoremap <silent> <Leader>fw <cmd>lua require('telescope.builtin').grep_string()<CR>
nnoremap <silent> <Leader>fb <cmd>lua require('telescope.builtin').buffers()<CR>
nnoremap <silent> <Leader>fh <cmd>lua require('telescope.builtin').help_tags()<CR>
nnoremap <silent> <Leader>fs <cmd>lua require('telescope.builtin').search_history()<CR>
nnoremap <silent> <Leader>fc <cmd>lua require('telescope.builtin').command_history()<CR>
nnoremap <silent> <Leader>fd <cmd>lua require('telescope.builtin').diagnostics()<CR>

" nnoremap <silent> <C-Right> :call BufferNext()<CR>
nnoremap <silent> <C-Right> :bnext<CR>
nnoremap <silent> <C-Left>  :bprevious<CR>

nnoremap <Leader>op :OpenProject
nnoremap <Leader>ot :OpenTerminal<CR>
nnoremap <Leader>bd :bdelete<CR>
nnoremap <Leader>bp :b#<CR>
nnoremap <Leader>om :Dispatch grip -b %<CR>
nnoremap <Leader>os :Outline<CR>

silent! colorscheme onedark

" Open file from last location
if has("autocmd")
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" add yaml stuffs
autocmd! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

autocmd FileType java setlocal ts=2 sts=2 sw=2 expandtab
" autocmd FileType cpp setlocal ts=2 sts=2 sw=2 expandtab

set encoding=utf-8
set switchbuf=usetab
set tabline=[%t]
set cursorline cursorcolumn
set number
set incsearch
set ignorecase smartcase
set expandtab smarttab
" set rnu
" set spell
"
set foldmethod=indent
" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable

fun! OpenProject(dir)
  exe ':NvimTreeClose'
  exe ':cd ' . a:dir
  exe ':bufdo bwipeout'
  exe ':NvimTreeOpen'
endfun

" Open bash terminal
fun! OpenTerm()
  exe ':belowright 10sp term://zsh'
endfun

" Command to change to a directory (also refreshes NvimTree)
command! -nargs=1 -complete=dir OpenProject :call OpenProject(<q-args>)
command! -nargs=0 OpenTerminal :call OpenTerm()

lua << EOF
local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<Up>'] = cmp.mapping.select_prev_item(),
    ['<Down>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = {
    {name = 'nvim_lsp'},
  }
})
local cap = require('cmp_nvim_lsp').default_capabilities()

require('lsp-format').setup{}

-- Registered language servers
-- require'lspconfig'.jdtls.setup{cmd={"jdtls", "--jvm-arg="..vim.api.nvim_eval("g:NVIM_LOMBOK")}, capabilities=cap}
require'lspconfig'.pylsp.setup{capabilities=cap}
require("lspconfig").ruff_lsp.setup({
    capabilities=cap,
    init_options = {
        settings = {  
            enable = true,
            ignoreStandardLibrary = true,
            organizeImports       = true, 
            fixAll                = true,
            lint = {
                enable = true,    
                run    = 'onType',
            },
        },
    },
})
require'lspconfig'.gopls.setup{capabilities=cap}
require'lspconfig'.clangd.setup{capabilities=cap, on_attach = require("lsp-format").on_attach}
--require'lspconfig'.bashls.setup{capabilities=cap, on_attach = require("lsp-format").on_attach}
require'lspconfig'.bashls.setup{capabilities=cap}
--require'lspconfig'.yamlls.setup{capabilities=cap}

-- Setup jdtls for filte type java using autocmd
vim.api.nvim_create_autocmd(
  {
    "BufNewFile",
    "BufRead",
  },
  {
    pattern = "*.java",
    callback = function()
      local config = {
        cmd = {'jdtls', "--jvm-arg="..vim.api.nvim_eval("g:NVIM_LOMBOK")},
        root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
      }
      require('jdtls').start_or_attach(config)
    end
  }
)

-- Telescope layout configuration
require('telescope').setup({
  defaults = {
    layout_strategy = 'vertical',
    layout_config = { width = 0.95, height = 0.95},
    -- path_display = {
    --  "shorten",
    --  function(opts, path)
    --    local tail = require("telescope.utils").path_tail(path)
    --    return string.format("%s (%s)", tail, path)
    --  end
    -- },
    mappings = {
      n = {
        ['<c-d>'] = require('telescope.actions').delete_buffer
      }, -- n
      i = {
        ["<C-h>"] = "which_key",
        ['<c-d>'] = require('telescope.actions').delete_buffer
      } -- i
    } -- mappings
  },
})

-- code formatter settings
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
          exe = 'ruff',
          args = {'format', "-q", "-"},
          stdin = true
        }
      end
    },
    sh = {require("formatter.filetypes.sh").shfmt},
    go = {
      function()
        return {
          exe = "gofmt",
          args = { vim.api.nvim_buf_get_name(0)},
          stdin = true
        }
      end
    }
  }
})


vim.api.nvim_exec([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.java,*.py,*.go,*.sh FormatWrite
augroup END
]], true)

require'nvim-web-devicons'.setup {}

-- nvim-tree
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  renderer = {
    group_empty = true,
  },
})

require("Comment").setup()

require("flutter-tools").setup {}

require("dashboard").setup ({
  theme = 'hyper',
  disable_move = false,
  shortcut_type = 'letter',
  change_to_vcs_root  = true,
  config = {
    week_header = {
      enable = true,
    },
  }, --  config used for theme
})

require("outline").setup({
  outline_window = {
    positiion = 'right',
    width = 25,
    relative_width = true,
    show_cursorline = true,
    hide_cursor = true,
  },
  outline_items = {
    show_symbol_details = false,
    highlight_hovered_item = true,
    auto_set_cursor = true,
  },
  symbol_folding = {
    autofold_depth = 1,
    auto_unfold = {
      hovered = true,
    },
  },
  symbols = {
    filter = {
      default = {'String', 'Variable', exclude=true},
      -- python = {'Function', 'Class'},
    },
  },
})
EOF
