vim.opt.incsearch = true
vim.opt.number = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.completeopt = { "menu", "menuone", "noselect" }
--vim.opt.showtabline = 2
vim.diagnostic.config({
	virtual_text = { current_line = true },
})
--vim.opt.switchbuf = "usetab"
--vim.opt.tabline = "[%t]"

vim.keymap.set("n", "<C-Right>", "<Cmd>bnext<CR>", { silent = true })
vim.keymap.set("n", "<C-Left>", "<Cmd>bprevious<CR>", { silent = true })

vim.keymap.set("n", "<leader>ca", function()
	vim.lsp.buf.code_action()
end)
vim.keymap.set("n", "<leader>rn", function()
	vim.lsp.buf.rename()
end)
vim.keymap.set("n", "<Leader>ho", function()
	vim.lsp.buf.hover()
end)
vim.keymap.set("n", "<leader>GD", "<Cmd>Gitsigns diffthis<CR>", { silent = true })
vim.keymap.set("n", "<leader>GB", "<Cmd>Gitsigns blame<CR>", { silent = true })

vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = { "*" },
	callback = function()
		if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
			vim.api.nvim_exec("normal! g'\"", false)
		end
	end,
})

--[[ -- This is a BLOCKING operation.
function show_command_output()
	local command = "ls -la"
	local command_output = vim.fn.system(command)
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(command_output, "\n"))

	local width = math.floor(vim.o.columns * 0.8)
	local height = math.floor(vim.o.lines * 0.8)
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	local opts = {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = "single",
	}
	vim.api.nvim_open_win(buf, true, opts)
end

--- Runs 'ping -c 4 google.com' asynchronously.
-- This is a NON-BLOCKING operation.
function show_long_command_output()
	local command = { "ping", "-c", "4", "google.com" }
	local output_lines = {}
	print("Starting long-running command...")

	vim.fn.jobstart(command, {
		on_stdout = function(_, data)
			for _, line in ipairs(data) do
				if line ~= "" then
					table.insert(output_lines, line)
				end
			end
		end,
		on_exit = function(_, exit_code)
			vim.schedule(function()
				if exit_code ~= 0 then
					print("Command failed with exit code: " .. exit_code)
					return
				end
				print("Command finished successfully.")
				local buf = vim.api.nvim_create_buf(false, true)
				vim.api.nvim_buf_set_lines(buf, 0, -1, false, output_lines)
				local width = math.floor(vim.o.columns * 0.8)
				local height = math.floor(vim.o.lines * 0.8)
				local row = math.floor((vim.o.lines - height) / 2)
				local col = math.floor((vim.o.columns - width) / 2)
				local opts = {
					relative = "editor",
					width = width,
					height = height,
					row = row,
					col = col,
					style = "minimal",
					border = "single",
				}
				vim.api.nvim_open_win(buf, true, opts)
			end)
		end,
	})
end

-- Now, create the user commands that call our functions.
vim.api.nvim_create_user_command(
	"ShowCommandOutput",
	show_command_output,
	{ nargs = 0, desc = "Run a fixed command (blocking)" }
)

vim.api.nvim_create_user_command(
	"ShowLongCommandOutput",
	show_long_command_output,
	{ nargs = 0, desc = "Run a long command asynchronously" }
) ]]
require("config.lazy")
