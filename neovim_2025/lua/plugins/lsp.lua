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
				ensure_installed = { "lua", "markdown", "markdown_inline", "yaml", "python", "go", "diff" },
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
			-- "L3MON4D3/LuaSnip",
			-- "saadparwaiz1/cmp_luasnip",
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				snippet = {
					expand = function(args)
						vim.fn["vsnip#anonymous"](args.body)
						-- require("luasnip").lsp_expand(args.body)
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
					{ name = "vsnip" },
					-- { name = "luasnip" },
					per_file_type = {
						codecompanion = { "codecompanion" },
					},
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
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			lspconfig.dartls.setup({ capabilities = capabilities })
			lspconfig.pylsp.setup({
				settings = {
					pylsp = {
						plugins = {
							pylint = {
								enabled = false,
							},
							mypy = {
								enabled = true,
							},
							pycodestyle = {
								maxLineLength = 100,
							},
							ruff = {
								enabled = true,
								formatEnabled = false,
								lintEnabled = true,
								lineLength = 100,
							},
							isort = {
								enabled = true,
								profile = "black",
							},
							pylsp_rope = {
								enabled = true,
								rename = { enabled = true },
								code_actions = { enabled = true },
							},
							jedi_completion = {
								enabled = true,
								include_params = true,
							},
						},
					},
				},
				capabilities = capabilities,
			})
			local mason_lspconfig = require("mason-lspconfig")
			-- Define all LSP servers and their specific configurations
			local servers = {
				-- pylsp = {},
				clangd = {},
				gopls = {},
				-- ruff = {
				-- 	settings = { -- Use 'settings' key for LSP specific configuration
				-- 		["ruff-lsp"] = { -- The actual server name might be different (e.g., 'ruff-lsp')
				-- 			enable = true,
				-- 			ignoreStandardLibrary = true,
				-- 			organizeImports = true,
				-- 			fixAll = true,
				-- 			lint = {
				-- 				enable = true,
				-- 				run = "onType",
				-- 			},
				-- 		},
				-- 	},
				-- 	init_options = { -- Use 'init_options' for specific server initialization options
				-- 		settings = { -- This structure depends on the LSP server's requirements
				-- 			-- Your ruff specific init_options here if needed
				-- 		},
				-- 	},
				-- },
				lua_ls = {},
			}

			mason_lspconfig.setup({
				ensure_installed = vim.tbl_keys(servers), -- Ensures all servers in 'servers' table are installed
				on_server_ready = function(server_name)
					local server_config = servers[server_name] or {} -- Get server specific config or empty table
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
						-- Merge default settings with server-specific settings
						settings = server_config.settings,
						init_options = server_config.init_options,
					})
				end,
			})
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
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {
			strategies = {
				--NOTE: Change the adapter as required
				chat = { adapter = "gemini" },
				inline = { adapter = "gemini" },
				cmd = { adapter = "gemini" },
			},
			opts = {
				log_level = "DEBUG",
			},
		},
		vim.keymap.set("n", "<leader>cc", "<cmd>CodeCompanionChat<cr>", { desc = "Toggle CodeCompanion Chat" }),
	},
}
