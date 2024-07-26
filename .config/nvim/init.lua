-----------------
---- OPTIONS ----
-----------------

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.number = true
vim.opt.cursorline = true
vim.opt.signcolumn = 'yes'
vim.opt.colorcolumn = '80'

vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.wrap = false

vim.opt.undofile = true
vim.opt.swapfile = false

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.scrolloff = 7
vim.opt.sidescrolloff = 12
vim.opt.updatetime = 150
vim.opt.timeoutlen = 1000

vim.opt.inccommand = 'split' -- Get list on renaming.
vim.opt.completeopt = { 'menuone', 'noselect', 'popup', 'fuzzy' }
vim.opt.autocomplete = true
vim.opt.complete = { 'o' }
vim.opt.pumheight = 5


-----------------
---- KEYMAPS ----
-----------------

vim.keymap.set('i', 'jj', '<Esc>')
vim.keymap.set('n', '<leader>w', '<cmd>w<CR>')
vim.keymap.set('n', '<leader>q', '<cmd>q<CR>')

-- Moving visual selection --
vim.keymap.set('v', 'J', ':m \'>+1<CR>gv=gv')
vim.keymap.set('v', 'K', ':m \'<-2<CR>gv=gv')

-- Jumping page blocks whilst keeping cursor in middle --
vim.keymap.set('n', '<C-d>', '10jzz')
vim.keymap.set('n', '<C-u>', '10kzz')

-- Searching keeps cursor in middle --
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Yanking to clipboard --
vim.keymap.set({ 'n', 'v' }, '<leader>y', '\"+y')
vim.keymap.set({ 'n', 'v' }, '<leader>yap', '\"+yap')

-- Renaming --
vim.keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")


------------------
---- PACKAGES ----
------------------

vim.pack.add({
	{ src = 'https://github.com/stevearc/oil.nvim' },
	{ src = 'https://github.com/nvim-mini/mini.pick' },
	{ src = 'https://github.com/kdheepak/lazygit.nvim' },
	{ src = 'https://github.com/neovim/nvim-lspconfig' },
	{ src = 'https://github.com/voylin/godot_color_theme' },
	{ src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
})

require('teledot')
require('haya').setup()

require('oil').setup({ delete_to_trash = true })
require('mini.pick').setup()

vim.keymap.set('n', '<leader>g', '<cmd>LazyGit<CR>')
vim.keymap.set('n', '<leader>e', require('oil').open)

-- For Godot projects, add a file called `.ignore` to your project and
-- add `*.uid` to it to ignore those files in the file picker.
vim.keymap.set('n', '<leader>pf', function() require('mini.pick').builtin.files() end)
vim.keymap.set('n', '<leader>pg', function() require('mini.pick').builtin.files({ tool = 'git' }) end)
vim.keymap.set('n', '<leader>ps', function() require('mini.pick').builtin.grep_live() end)
vim.keymap.set('n', '<leader>pr', function() require('mini.pick').builtin.resume() end)
vim.keymap.set('n', '<leader>h', function() require('mini.pick').builtin.help() end)

vim.cmd('colorscheme godot')
require('godot_theme').setup({
	is_modern = false,
	base_color = '#363d4a',
	accent_color = '#70bafa',
	contrast = 0.2,
})

require('nvim-treesitter').install({
	'zig', 'markdown', 'yaml', 'python',
	'c', 'cpp', 'c_sharp',
	'gdscript', 'gdshader', 'godot_resource' })
vim.api.nvim_create_autocmd("FileType", { callback = function(args) pcall(vim.treesitter.start, args.buf) end, })


-------------
---- LSP ----
-------------

vim.lsp.config('clangd', { cmd = { 'clangd', '--header-insertion=never' } })
vim.lsp.config('lua_ls', { settings = { Lua = { workspace = { library = vim.api.nvim_get_runtime_file('', true) } } } })

vim.lsp.enable({
	'zls',
	'clangd',
	'lua_ls',
	'pyright',
	'gdscript',
	'html', 'cssls', 'ts_ls' }
)

vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', '<C-s>', vim.lsp.buf.signature_help)
vim.keymap.set({ 'n', 'i' }, '<C-h>', vim.lsp.buf.hover)

vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1, float = true }) end)
vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1, float = true }) end)

-----------------
---- EXTRA'S ----
-----------------

-- Remove trailing spaces and tabs on save --
vim.api.nvim_create_autocmd('BufWritePre', { pattern = '*', command = [[%s/\s\+$//e]] })

-- Format on save --
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('LspFormat', { clear = true }),
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if not client then return end
		if client:supports_method('textDocument/completion') then
			vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
		end
		if client:supports_method('textDocument/formatting') then
			vim.api.nvim_create_autocmd('BufWritePre', {
				buffer = args.buf,
				callback = function()
					vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
				end,
			})
		end
	end,
})

-- Markdown navigation --
vim.api.nvim_create_autocmd('BufWinEnter', {
	pattern = '*.md',
	callback = function()
		vim.opt_local.colorcolumn = ''
		vim.opt_local.wrap = true

		vim.keymap.set('n', 'j', 'gj', { buffer = true })
		vim.keymap.set('n', 'k', 'gk', { buffer = true })
	end,
})

-- Highlight on yank --
vim.api.nvim_create_autocmd('textyankpost',
	{ callback = function() vim.highlight.on_yank({ higroup = 'incsearch', timeout = 200 }) end, })
