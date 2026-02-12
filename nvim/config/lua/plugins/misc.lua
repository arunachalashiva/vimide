return {
	{
		"navarasu/onedark.nvim",
		config = function()
			require("onedark").setup({
				style = "darker",
				transparent = true,
				cmp_itemkind_reverse = true,
				term_colors = true,
				lualine = {
					transparent = true,
				},
			})
			--require("onedark").load()
		end,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
		config = function()
			require("tokyonight").setup({})
			-- require("tokyonight").load()
			vim.cmd([[colorscheme tokyonight-night]])
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		config = function()
			require("catppuccin").setup({
				flavour = "auto",
			})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = true,
					-- theme = "catppuccin",
					theme = "tokyonight-night",
					always_show_tabline = true,
					path = "absolute",
				},
				tabline = {
					lualine_b = {
						{
							"buffers",
							show_modified_status = true,
							show_filename_only = false,
							mode = 0,
						},
					},
				},
				sections = {
					lualine_c = {
						{ "filename", path = 2 },
					},
				},
			})
		end,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "which-key",
			},
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "+" },
					change = { text = "┃" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
					untracked = { text = "┆" },
				},
				signs_staged = {
					add = { text = "+" },
					change = { text = "┃" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
					untracked = { text = "┆" },
				},
				signs_staged_enable = true,
				signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
				numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
				linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
				word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
				watch_gitdir = {
					follow_files = true,
				},
				auto_attach = true,
				attach_to_untracked = false,
				current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
					delay = 1000,
					ignore_whitespace = false,
					virt_text_priority = 100,
					use_focus = true,
				},
				current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
				sign_priority = 6,
				update_debounce = 100,
				status_formatter = nil, -- Use default
				max_file_length = 40000, -- Disable if file is longer than this (in lines)
				preview_config = {
					-- Options passed to nvim_open_win
					border = "single",
					style = "minimal",
					relative = "cursor",
					row = 0,
					col = 1,
				},
			})
		end,
	},
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			bigfile = { enabled = true },
			dashboard = { enabled = true },
			explorer = {
				enabled = true,
				files = {
					hidden = true,
				},
			},
			indent = { enabled = true },
			input = { enabled = true },
			notifier = { enabled = true },
			quickfile = { enabled = true },
			scope = { enabled = true },
			scroll = { enabled = true },
			statuscolumn = { enabled = true },
			words = { enabled = true },
			picker = {
				enabled = true,
				files = {
					hidden = true,
				},
				formatters = {
					file = {
						-- filename_first = true,
						truncate = 100,
					},
				},
				grep_word = {
					live = false,
					supports_live = true,
				},
			},
		},
		keys = {
			{
				"<leader>gd",
				function()
					Snacks.picker.lsp_definitions()
				end,
				desc = "Goto Definition",
			},
			{
				"<leader>gr",
				function()
					Snacks.picker.lsp_references()
				end,
				desc = "Goto References",
			},
			{
				"<leader>gi",
				function()
					Snacks.picker.lsp_implementations()
				end,
				desc = "Goto Implementations",
			},
			{
				"<leader>gD",
				function()
					Snacks.picker.lsp_declarations()
				end,
				desc = "Goto Declarations",
			},
			{
				"<leader>gt",
				function()
					Snacks.picker.lsp_type_definitions()
				end,
				desc = "Goto Type definitions",
			},
			{
				"<leader>ss",
				function()
					Snacks.picker.lsp_symbols()
				end,
				desc = "Show Symbols",
			},
			{
				"<leader>gw",
				function()
					Snacks.picker.lsp_workspace_symbols()
				end,
				desc = "Goto Workspace Symbols",
			},
			{
				"<leader>ot",
				function()
					Snacks.terminal("zsh", {
						win = {
							--position = "bottom",
							position = "float",
							height = 0.8,
							width = 0.8,
							-- border = "rounded",
						},
					})
				end,
				desc = "Toggle terminal",
			},
			{
				"<leader>ff",
				function()
					Snacks.picker.files()
				end,
				desc = "Find files",
			},
			{
				"<leader>fr",
				function()
					Snacks.picker.recent()
				end,
				desc = "Find recent files",
			},
			{
				"<leader>fg",
				function()
					Snacks.picker.grep()
				end,
				desc = "Find text",
			},
			{
				"<leader>fw",
				function()
					Snacks.picker.grep_word()
				end,
				desc = "Find word",
				mode = { "n", "x" },
			},
			{
				"<leader>fb",
				function()
					Snacks.picker.buffers()
				end,
				desc = "Find files",
			},
			{
				"<leader>fs",
				function()
					Snacks.picker.search_history()
				end,
				desc = "Find search history",
			},
			{
				"<leader>fc",
				function()
					Snacks.picker.command_history()
				end,
				desc = "Find command history",
			},
			{
				"<leader>sf",
				function()
					Snacks.picker.smart()
				end,
				desc = "Smart find files",
			},
			{
				"<leader>ex",
				function()
					Snacks.explorer()
				end,
				desc = "File explorer",
			},
			{
				"<leader>dd",
				function()
					Snacks.picker.diagnostics_buffer()
				end,
				desc = "Buffer diagnostics",
			},
			{
				"<leader>Gb",
				function()
					Snacks.picker.git_branches()
				end,
				desc = "Git Branches",
			},
			{
				"<leader>Gl",
				function()
					Snacks.picker.git_log()
				end,
				desc = "Git Log",
			},
			{
				"<leader>GL",
				function()
					Snacks.picker.git_log_line()
				end,
				desc = "Git Log Line",
			},
			{
				"<leader>Gs",
				function()
					Snacks.picker.git_status()
				end,
				desc = "Git Status",
			},
			{
				"<leader>GS",
				function()
					Snacks.picker.git_stash()
				end,
				desc = "Git Stash",
			},
			{
				"<leader>Gd",
				function()
					Snacks.picker.git_diff()
				end,
				desc = "Git Diff (Hunks)",
			},
			{
				"<leader>Gf",
				function()
					Snacks.picker.git_log_file()
				end,
				desc = "Git Log File",
			},
			{
				"<leader>GF",
				function()
					Snacks.picker.git_files()
				end,
				desc = "Git Log File",
			},
			{
				"<leader>lg",
				function()
					Snacks.lazygit()
				end,
				desc = "Lazygit",
			},
			{
				"<leader>bd",
				function()
					Snacks.bufdelete()
				end,
				desc = "delete buffer",
			},
			{
				"<leader>zm",
				function()
					Snacks.zen()
				end,
				desc = "Toggle Zen Mode",
			},
			{
				"<leader>db",
				function()
					Snacks.dashboard()
				end,
				desc = "Open dashboard",
			},
		},
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
		ft = { "markdown", "codecompanion" },
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {},
	},
	{
		"nvim-flutter/flutter-tools.nvim",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		-- config = true,
		config = function()
			require("flutter-tools").setup({})
		end,
	},
	{
		"arunachalashiva/mvndisp",
		config = function(plugin)
			vim.opt.rtp:append(plugin.dir .. "/mvn_wrapper.nvim")
			local mvn_wrapper = require("mvn_wrapper")
			mvn_wrapper.setup()
		end,
	},
}
