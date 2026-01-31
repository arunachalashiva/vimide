return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		lazy = false,
		branch = "master",
		config = function()
			local configs = require("nvim-treesitter.configs")
			configs.setup({
				ensure_installed = {
					"c",
					"cpp",
					"cuda",
					"java",
					"lua",
					"markdown",
					"markdown_inline",
					"yaml",
					"python",
					"go",
					"diff",
					"bash",
				},
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true },
				additional_vim_regex_highlighting = false,
			})
		end,
	},
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
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			-- "hrsh7th/cmp-vsnip",
			-- "hrsh7th/vim-vsnip",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			cmp.setup({
				snippet = {
					expand = function(args)
						-- vim.fn["vsnip#anonymous"](args.body)
						luasnip.lsp_expand(args.body)
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
					-- { name = "vsnip" },
					{ name = "luasnip" },
					{ name = "buffer" },
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
					prepend_args = { "-i", "2", "-bn" },
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
			require("mason").setup({
				ensured_installed = {
					"bandit",
					"black",
					"clangd",
					"google-java-format",
					"gopls",
					"lua-language-server",
					"python-lsp-server",
					"stylua",
					"yamlfmt",
					"json-lsp",
				},
			})
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			vim.lsp.config("dartls", { capabilities = capabilities })
			local mason_lspconfig = require("mason-lspconfig")

			-- Define all LSP servers and their specific configurations
			local servers = {
				pylsp = {
					pylsp = {
						plugins = {
							jedi_completion = {
								enabled = true,
								include_params = true,
								include_class_objects = true,
								include_function_objecs = true,
								-- eager = true,
								-- fuzzy = true,
							},
							pylint = {
								enabled = false,
							},
							mypy = {
								enabled = false,
							},
							pycodestyle = {
								enabled = true,
								maxLineLength = 100,
							},
							black = {
								enabled = true,
							},
							autopep8 = {
								enabled = false,
							},
							ruff = {
								enabled = false,
							},
							isort = {
								enabled = false,
								profile = "black",
							},
							rope = {
								enabled = false,
								rename = { enabled = false },
								code_actions = { enabled = false },
							},
							rope_completion = {
								enabled = false,
							},
						},
					},
				},
				--[[ ruff = {
					settings = {
						lint = { enable = true },
						format = { preview = true },
					},
				}, ]]
				clangd = {},
				gopls = {},
				jsonls = {},
				bashls = {},
				lua_ls = {
					Lua = {
						workspace = {
							library = {
								"$VIMRUNTIME",
							},
							checkThirdParty = false,
						},
					},
				},
			}

			for _name, _settings in pairs(servers) do
				vim.lsp.config(_name, {
					capabilities = capabilities,
					on_attach = on_attach,
					settings = _settings,
				})
			end

			mason_lspconfig.setup({
				ensure_installed = vim.tbl_keys(servers), -- Ensures all servers in 'servers' table are installed
				automatic_enable = true,
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
		"stevearc/aerial.nvim",
		config = function()
			require("aerial").setup({
				on_attach = function(bufnr)
					vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
					vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
				end,
			})
			vim.keymap.set("n", "<leader>os", "<cmd>AerialToggle!<CR>")
		end,
		opts = {},
		-- Optional dependencies
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
	},
	{
		"olimorris/codecompanion.nvim",
		-- tag = "v17.33.0",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {
			display = {
				chat = {
					window = {
						layout = "buffer",
						buflisted = true,
						sticky = true,
					},
				},
			},
			interactions = {
				chat = { adapter = "gemini" },
				inline = { adapter = "gemini" },
				cmd = { adapter = "gemini" },
			},
			opts = {
				log_level = "DEBUG",
			},
			adapters = {
				acp = {
					gemini_cli = function()
						return require("codecompanion.adapters").extend("gemini_cli", {
							defaults = {
								auth_method = "gemini-api-key",
								timeout = 20000,
							},
							env = {
								api_key = "GEMINI_API_KEY",
							},
						})
					end,
				},
			},
		},
		vim.keymap.set("n", "<leader>cc", "<cmd>CodeCompanionChat<cr>", { desc = "Toggle CodeCompanion Chat" }),
		vim.keymap.set(
			"n",
			"<leader>ca",
			"<cmd>CodeCompanionChat adapter=gemini_cli<cr>",
			{ desc = "Toggle CodeCompanion Agent Chat" }
		),
	},
	{
		"ray-x/lsp_signature.nvim",
		event = "InsertEnter",
		opts = {
			bind = true,
			floating_window = true,
			hint_enable = true,
			handler_opts = {
				border = "rounded",
			},
		},
	},
}
