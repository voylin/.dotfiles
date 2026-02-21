require('voylin.set')
require('voylin.remap')
require('voylin.lazy_init')
require('voylin.markdown')

-- Remove trailing spaces and tabs on save.
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

local augroup = vim.api.nvim_create_augroup
local VoylinGroup = augroup('Voylin', {})
local autocmd = vim.api.nvim_create_autocmd

function R(name)
	require('plenary.reload').reload_module(name)
end

autocmd('LspAttach', {
	group = VoylinGroup,
	callback = function(e)
		local opts = { buffer = e.buf }
		vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
		vim.keymap.set('n', '<leader>gd', function() vim.lsp.buf.type_definition() end, opts)
		vim.keymap.set('n', '<leader>vca', function() vim.lsp.buf.code_action() end, opts)
		vim.keymap.set('i', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)

		-- Diagnostic keymaps
		vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
		vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
		vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
	end
})
