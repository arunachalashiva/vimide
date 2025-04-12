return {
	-- One dark theme
	"joshdick/onedark.vim",

	-- Nvim tree
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		sort_by = "case_sensitive",
		renderer = {
			group_empty = true,
		},
	},
	-- Lualine
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = "gruvbox_dark",
				},
				sections = {
					lualine_a = {
						{
							"buffers",
							show_modified_status = true,
							mode = 0,
						},
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
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			bigfile = { enabled = true },
			dashboard = { enabled = true },
			explorer = { enabled = true },
			indent = { enabled = true },
			input = { enabled = true },
			picker = { enabled = true },
			notifier = { enabled = true },
			quickfile = { enabled = true },
			scope = { enabled = true },
			scroll = { enabled = true },
			statuscolumn = { enabled = true },
			words = { enabled = true },
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
					Snacks.terminal()
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
				"<leader>gb",
				function()
					Snacks.picker.git_branches()
				end,
				desc = "Git Branches",
			},
			{
				"<leader>gl",
				function()
					Snacks.picker.git_log()
				end,
				desc = "Git Log",
			},
			{
				"<leader>gL",
				function()
					Snacks.picker.git_log_line()
				end,
				desc = "Git Log Line",
			},
			{
				"<leader>gs",
				function()
					Snacks.picker.git_status()
				end,
				desc = "Git Status",
			},
			{
				"<leader>gS",
				function()
					Snacks.picker.git_stash()
				end,
				desc = "Git Stash",
			},
			{
				"<leader>gg",
				function()
					Snacks.picker.git_diff()
				end,
				desc = "Git Diff (Hunks)",
			},
			{
				"<leader>gf",
				function()
					Snacks.picker.git_log_file()
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
				"<leader>z",
				function()
					Snacks.zen()
				end,
				desc = "Toggle Zen Mode",
			},
		},
	},
}
