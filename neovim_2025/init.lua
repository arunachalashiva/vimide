vim.opt.incsearch = true
vim.opt.number = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.completeopt = "menu,menuone,noselect"
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

require("config.lazy")
