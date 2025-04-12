vim.opt.incsearch = true
vim.opt.number = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.keymap.set("n", "<C-Right>", "<Cmd>bNext<CR>", { silent = true })
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

require("config.lazy")
