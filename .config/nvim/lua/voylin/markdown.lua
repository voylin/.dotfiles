vim.api.nvim_create_autocmd("BufWinEnter", {
	pattern = "*.md",
	callback = function()
		vim.keymap.set('n', 'j', 'gj', { buffer = true })
		vim.keymap.set('n', 'k', 'gk', { buffer = true })
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
		vim.opt_local.colorcolumn = "" -- This disables the column line
	end,
})
