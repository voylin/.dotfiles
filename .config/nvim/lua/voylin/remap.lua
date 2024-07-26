vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('n', '<leader>pv', vim.cmd.Rex)

-- Insert escaping
vim.keymap.set('i', 'jj', '<Esc>')

-- Highlight when yanking (copying) text
--  `yap` to copy entire paragraph
vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
	group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Moving visual selection
vim.keymap.set('v', 'J', ':m \'>+1<CR>gv=gv')
vim.keymap.set('v', 'K', ':m \'<-2<CR>gv=gv')

-- Jumping page blocks whilst keeping cursor in middle
vim.keymap.set('n', '<C-D>', '<C-d>zz')
vim.keymap.set('n', '<C-U>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '10jzz')
vim.keymap.set('n', '<C-u>', '10kzz')

-- Searching keeps cursor in middle
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Yanking to clipboard
vim.keymap.set('n', '<leader>y', '\"+y')
vim.keymap.set('v', '<leader>y', '\"+y')
vim.keymap.set('n', '<leader>yap', '\"+yap')
vim.keymap.set('v', '<leader>yap', '\"+yap')

vim.keymap.set('n', '<leader>f', function()
	vim.lsp.buf.format()
end)

vim.keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set('n', '<leader>S', [[:%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set('i', '<C-c>', '<Esc>')

vim.keymap.set('n', '<leader>g', ':LazyGit<CR>')
