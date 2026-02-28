vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.guicursor = ''
vim.opt.signcolumn = 'yes'
vim.opt.colorcolumn = '80'
vim.opt.winborder = 'rounded'

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false

vim.opt.breakindent = true
vim.opt.smartindent = true
vim.opt.wrap = false

vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir'

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.updatetime = 150
vim.opt.timeoutlen = 1000

--vim.opt.list = true
--vim.opt.listchars = {
--	tab = '»  ',
--	leadmultispace = '≈   ',
--	trail = '·',
--	extends = '›',
--	precedes = '‹',
--	nbsp = '␣',
--}

vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10
vim.opt.cursorline = true

vim.opt.inccommand = 'split' -- Get list on renaming.
vim.opt.completeopt = {      -- Fuzzy autocomplete.
	'menu',
	'menuone',
	'noselect',
	'fuzzy',
	'nearest',
}

-------------------------------------------------------------------------------
------------ KEYMAPS ----------------------------------------------------------
-------------------------------------------------------------------------------

vim.keymap.set('i', 'jj', '<Esc>')
vim.keymap.set('n', '<leader>w', ':silent w<CR>')
vim.keymap.set('n', '<leader>q', ':q<CR>')

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
vim.keymap.set('n', '<leader>S', [[:%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Tab to confirm autocompletion --
vim.keymap.set('i', '<Tab>', function()
	if vim.fn.pumvisible() == 1 then
		return vim.fn.complete_info()['selected'] == -1 and '<C-n><C-y>' or '<C-y>'
	end
	return '<Tab>'
end, { expr = true })


-------------------------------------------------------------------------------
------------ PACKAGES ---------------------------------------------------------
-------------------------------------------------------------------------------

vim.pack.add({
	{ src = 'https://github.com/stevearc/oil.nvim' },
	{ src = 'https://github.com/nvim-mini/mini.nvim' },
	{ src = 'https://github.com/kdheepak/lazygit.nvim' },
	{ src = 'https://github.com/neovim/nvim-lspconfig' },
	{ src = 'https://github.com/mfussenegger/nvim-dap' },
	{ src = 'https://github.com/williamboman/mason.nvim' },
	{ src = 'https://github.com/voylin/godot_color_theme' },
	{ src = 'https://github.com/folke/todo-comments.nvim' },
	{ src = 'https://github.com/nvim-tree/nvim-web-devicons' },
	{ src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
	{ src = 'https://github.com/nvim-treesitter/nvim-treesitter-context' },
	{ src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects' },
})
require("haya").setup()

require('oil').setup()
require('mason').setup()
require('todo-comments').setup()
require('mini.completion').setup()
require('mini.pick').setup()

vim.keymap.set('n', '<leader>g', ':LazyGit<CR>')

vim.keymap.set('n', '<leader>e', require('oil').open)

-- For Godot projects, add a file called `.ignore` to your project and
-- add `*.uid` to it to ignore those files in the file picker.
vim.keymap.set('n', '<leader>pf', function() require('mini.pick').builtin.files() end)
vim.keymap.set('n', '<leader>pg', function() require('mini.pick').builtin.files({ tool = 'git' }) end)
vim.keymap.set('n', '<leader>ps', function() require('mini.pick').builtin.grep_live() end)
vim.keymap.set('n', '<leader>h', function() require('mini.pick').builtin.help() end)

vim.cmd('colorscheme godot')
require('godot_theme').setup({
	is_modern = false,
	base_color = '#363d4a',
	accent_color = '#70bafa',
	contrast = 0.2,
})

local ts = require('nvim-treesitter')
ts.install({
	'c', 'cpp',
	'zig', 'rust',
	'yaml', 'query', 'markdown',
	'vim', 'vimdoc', 'lua', 'python',
	'gdscript', 'gdshader', 'godot_resource',
})
vim.api.nvim_create_autocmd('FileType', {
	group = vim.api.nvim_create_augroup('treesitter-start', { clear = true }),
	callback = function(args)
		local buf = args.buf
		local lang = vim.bo[buf].filetype
		local has_parser = pcall(vim.treesitter.language.add, lang)
		if not has_parser then pcall(ts.install, { lang }) end

		local ok = pcall(vim.treesitter.start, buf)
		if ok then
			vim.bo[buf].indentexpr = 'v:lua.require"nvim-treesitter".indentexpr()'
		end
		if lang == 'yaml' or lang == 'markdown' then vim.bo[buf].syntax = 'on' end
	end,
})

require('nvim-treesitter-textobjects').setup({
	move = { set_jumps = true } })

vim.keymap.set({ 'n', 'x', 'o' }, ']]',
	function() require('nvim-treesitter-textobjects.move').goto_next_start('@function.outer') end)
vim.keymap.set({ 'n', 'x', 'o' }, ']m',
	function() require('nvim-treesitter-textobjects.move').goto_next_end('@function.outer') end)
vim.keymap.set({ 'n', 'x', 'o' }, '[[',
	function() require('nvim-treesitter-textobjects.move').goto_previous_start('@function.outer') end)
vim.keymap.set({ 'n', 'x', 'o' }, '[m',
	function() require('nvim-treesitter-textobjects.move').goto_previous_end('@function.outer') end)

require('treesitter-context').setup({
	max_lines = 3,
	trim_scope = "inner",
	mode = "cursor",
})


-------------------------------------------------------------------------------
------------ DAP --------------------------------------------------------------
-------------------------------------------------------------------------------

vim.keymap.set('n', '<leader>db', require('dap').toggle_breakpoint)
vim.keymap.set('n', '<F6>', require('dap').continue)
vim.keymap.set('n', '<F7>', require('dap').step_over)
vim.keymap.set('n', '<F8>', require('dap').step_into)
vim.keymap.set('n', '<F9>', require('dap').step_out)
vim.keymap.set('n', '<F10>', function() require('dap').terminate() end)

-- Godot stuff
require('dap').adapters.godot = { type = 'server', host = '127.0.0.1', port = 6007 }
require('dap').configurations.gdscript = { {
	type = 'godot',
	request = 'launch',
	name = 'Launch scene',
	project = '${workspaceFolder}/src',
	launch_scene = true,
} }


-------------------------------------------------------------------------------
------------ LSP --------------------------------------------------------------
-------------------------------------------------------------------------------

vim.lsp.enable({ 'lua_ls', 'pyright', 'zls', 'clangd', 'gdscript' })
vim.lsp.config('lua_ls', { -- For getting rid of the VIM warnings.
	settings = {
		Lua = {
			workspace = {
				library = vim.api.nvim_get_runtime_file('', true) }
		}
	}
})

vim.lsp.config('clangd', { cmd = { "clangd", "--header-insertion=never" } })
local godot_project = vim.fs.find(
	'project.godot', {
		type = 'file',
		path = vim.fn.getcwd(),
		limit = 1,
		upward = false,
	}
)
if #godot_project > 0 then
	local rel = vim.fn.fnamemodify(godot_project[1], ':.')
	local depth = select(2, rel:gsub('/', ''))
	if depth <= 1 then vim.fn.serverstart('127.0.0.1:6004') end
end

vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action)
vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename)
vim.keymap.set({ 'n', 'i' }, '<C-s>', vim.lsp.buf.signature_help)
vim.keymap.set({ 'n', 'i' }, '<C-h>', vim.lsp.buf.hover)
vim.keymap.set('n', '<C-o>', vim.diagnostic.open_float)

vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1, float = true }) end)
vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1, float = true }) end)
vim.keymap.set('n', '<leader>pv', function() end)


-------------------------------------------------------------------------------
------------ EXTRA'S ----------------------------------------------------------
-------------------------------------------------------------------------------

-- Markdown navigation --
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

-- Remove trailing spaces and tabs on save --
vim.api.nvim_create_autocmd("BufWritePre", { pattern = "*", command = [[%s/\s\+$//e]] })

-- Highlight on yanking --
vim.api.nvim_create_autocmd('TextYankPost', {
	group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Format on save --
vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function(args)
		vim.lsp.buf.format({ bufnr = args.buf, async = false })
	end,
})

-- Treesitter updater --
vim.api.nvim_create_autocmd('PackChanged', {
	desc = 'Handle nvim-treesitter updates',
	group = vim.api.nvim_create_augroup('nvim-treesitter-pack-changed-update-handler', { clear = true }),
	callback = function(event)
		if event.data.kind == 'update' and event.data.spec.name == 'nvim-treesitter' then
			vim.notify('nvim-treesitter updated, running TSUpdate...', vim.log.levels.INFO)
			---@diagnostic disable-next-line: param-type-mismatch
			local ok = pcall(vim.cmd, 'TSUpdate')
			if ok then
				vim.notify('TSUpdate completed successfully!', vim.log.levels.INFO)
			else
				vim.notify('TSUpdate command not available yet, skipping', vim.log.levels.WARN)
			end
		end
	end,
})

-- Disable next lines being commented after comment --
vim.api.nvim_create_autocmd('FileType', {
	callback = function() vim.opt_local.formatoptions:remove({ 'o', 'r' }) end,
})
