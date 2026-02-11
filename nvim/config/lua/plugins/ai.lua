return {
	{
		"ravitemer/mcphub.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		build = "bundled_build.lua", -- Bundles `mcp-hub` binary along with the neovim plugin
		config = function()
			require("mcphub").setup({
				use_bundled_binary = true, -- Use local `mcp-hub` binary
			})
		end,
	},
	{
		"olimorris/codecompanion.nvim",
		-- tag = "v17.33.0",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"ravitemer/codecompanion-history.nvim",
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
			extensions = {
				mcphub = {
					callback = "mcphub.extensions.codecompanion",
					opts = {
						-- MCP Tools
						make_tools = true, -- Make individual tools (@server__tool) and server groups (@server) from MCP servers
						show_server_tools_in_chat = true, -- Show individual tools in chat completion (when make_tools=true)
						add_mcp_prefix_to_tool_names = false, -- Add mcp__ prefix (e.g `@mcp__github`, `@mcp__neovim__list_issues`)
						show_result_in_chat = true, -- Show tool results directly in chat buffer
						format_tool = nil, -- function(tool_name:string, tool: CodeCompanion.Agent.Tool) : string Function to format tool names to show in the chat buffer
						-- MCP Resources
						make_vars = true, -- Convert MCP resources to #variables for prompts
						-- MCP Prompts
						make_slash_commands = true, -- Add MCP prompts as /slash commands
					},
				},
				history = {
					enabled = true,
					opts = {
						-- Keymap to open history from chat buffer (default: gh)
						keymap = "gh",
						-- Keymap to save the current chat manually (when auto_save is disabled)
						save_chat_keymap = "sc",
						-- Save all chats by default (disable to save only manually using 'sc')
						auto_save = true,
						-- Number of days after which chats are automatically deleted (0 to disable)
						expiration_days = 0,
						-- Picker interface (auto resolved to a valid picker)
						picker = "snacks", --- ("telescope", "snacks", "fzf-lua", or "default")
						---Optional filter function to control which chats are shown when browsing
						chat_filter = nil, -- function(chat_data) return boolean end
						-- Customize picker keymaps (optional)
						picker_keymaps = {
							rename = { n = "r", i = "<C-r>" },
							delete = { n = "d", i = "<C-d>" },
							duplicate = { n = "<C-y>", i = "<C-y>" },
						},
						---Automatically generate titles for new chats
						auto_generate_title = true,
						title_generation_opts = {
							---Adapter for generating titles (defaults to current chat adapter)
							adapter = nil, -- "copilot"
							---Model for generating titles (defaults to current chat model)
							model = nil, -- "gpt-4o"
							---Number of user prompts after which to refresh the title (0 to disable)
							refresh_every_n_prompts = 0, -- e.g., 3 to refresh after every 3rd user prompt
							---Maximum number of times to refresh the title (default: 3)
							max_refreshes = 3,
							format_title = function(original_title)
								-- this can be a custom function that applies some custom
								-- formatting to the title.
								return original_title
							end,
						},
						---On exiting and entering neovim, loads the last chat on opening chat
						continue_last_chat = false,
						---When chat is cleared with `gx` delete the chat from history
						delete_on_clearing_chat = false,
						---Directory path to save the chats
						dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
						---Enable detailed logging for history extension
						enable_logging = false,

						-- Summary system
						summary = {
							-- Keymap to generate summary for current chat (default: "gcs")
							create_summary_keymap = "gcs",
							-- Keymap to browse summaries (default: "gbs")
							browse_summaries_keymap = "gbs",

							generation_opts = {
								adapter = nil, -- defaults to current chat adapter
								model = nil, -- defaults to current chat model
								context_size = 90000, -- max tokens that the model supports
								include_references = true, -- include slash command content
								include_tool_outputs = true, -- include tool execution results
								system_prompt = nil, -- custom system prompt (string or function)
								format_summary = nil, -- custom function to format generated summary e.g to remove <think/> tags from summary
							},
						},

						--[[ -- Memory system (requires VectorCode CLI)
						memory = {
							-- Automatically index summaries when they are generated
							auto_create_memories_on_summary_generation = true,
							-- Path to the VectorCode executable
							vectorcode_exe = "vectorcode",
							-- Tool configuration
							tool_opts = {
								-- Default number of memories to retrieve
								default_num = 10,
							},
							-- Enable notifications for indexing progress
							notify = true,
							-- Index all existing memories on startup
							-- (requires VectorCode 0.6.12+ for efficient incremental indexing)
							index_on_startup = false,
						}, ]]
					},
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
}
