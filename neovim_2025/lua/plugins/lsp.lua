return {
	"nvim-lua/plenary.nvim",
	{
		"numToStr/Comment.nvim",
		opts = {
			toggler = {
				line = "<leader>cl",
				block = "<leader>cb",
			},
			opleader = {
				line = "<leader>cl",
				block = "<leader>cb",
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")
			configs.setup({
				-- ensure_installed = { "c", "lua", "java", "python", "go" },
				highlight = { enabled = true },
				indent = { enabled = true },
			})
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-vsnip",
			"hrsh7th/vim-vsnip",
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				snippet = {
					expand = function(args)
						vim.fn["vsnip#anonymous"](args.body)
					end,
				},
				mapping = {
					["<Up>"] = cmp.mapping.select_prev_item(),
					["<Down>"] = cmp.mapping.select_next_item(),
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.close(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				},
				sources = {
					{ name = "nvim_lsp" },
				},
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		opts = {
			formatters_by_ft = {
				go = { "gofmt" },
				python = { "black" },
				java = { "google-java-format" },
				lua = { "stylua" },
				--yaml = { "yamlfmt" },
			},
			-- Set default options
			default_format_opts = {
				lsp_format = "fallback",
			},
			-- Set up format-on-save
			format_on_save = { timeout_ms = 3000 },
			-- Customize formatters
			formatters = {
				shfmt = {
					prepend_args = { "-i", "2" },
				},
			},
		},
		init = function()
			-- If you want the formatexpr, here is the place to set it
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		end,
	},
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = { "clangd", "gopls", "pylsp", "lua_ls" },
			})

			local lspconfig = require("lspconfig")
			local cap = require("cmp_nvim_lsp").default_capabilities()
			lspconfig.gopls.setup({ capabilities = cap })
			lspconfig.clangd.setup({ capabilities = cap })
			lspconfig.pylsp.setup({ capabilities = cap })
			--lspconfig.ruff.setup({
			--	capabilities = cap,
			--init_options = {
			--	settings = {
			--		enable = true,
			--			ignoreStandardLibrary = true,
			--			organizeImports = true,
			--			fixAll = true,
			--			lint = {
			--				enable = true,
			--				run = "onType",
			--			},
			--	},
			--},
			--})
			lspconfig.lua_ls.setup({ capabilities = cap })
		end,
	},
	{
		"mfussenegger/nvim-jdtls",
		dependencies = {
			"neovim/nvim-lspconfig",
		},
		config = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "java",
				callback = function()
					local nvim_jdtls = require("jdtls")
					local lombok_jar = vim.fn.expand("~") .. "/data/lombok-1.18.36.jar"
					local jdtls_args = "--jvm-arg=-javaagent:" .. lombok_jar
					nvim_jdtls.start_or_attach({
						cmd = { "jdtls", jdtls_args },
						root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
						settings = {
							java = {
								signatureHelp = { enabled = true },
								completion = { enabled = true },
							},
						},
						flags = {
							allow_incremental_sync = true,
							debounce_text_changes = 80,
						},
					})
				end,
			})
		end,
	},
	{
		"hedyhli/outline.nvim",
		config = function()
			vim.keymap.set("n", "<leader>os", "<cmd>Outline<CR>", { desc = "Toggle Outline" })
			require("outline").setup({
				outline_window = {
					positiion = "right",
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
						default = { "String", "Variable", exclude = true },
						-- python = {'Function', 'Class'},
					},
				},
			})
		end,
	},
}
