vim.opt.guicursor = ''
vim.opt.mouse = 'a' -- Enabling mouse mode

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showmode = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false

vim.opt.breakindent = true
vim.opt.smartindent = true
vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.termguicolors = true

vim.opt.signcolumn = 'yes'
vim.opt.isfname:append('@-@')
vim.opt.colorcolumn = '80'

vim.opt.updatetime = 150
vim.opt.timeoutlen = 1000

vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.inccommand = 'split'

vim.opt.list = true
vim.opt.listchars = {
	tab = '»  ',
	leadmultispace = '≈   ',
	trail = '·',
	extends = '›',
	precedes = '‹',
	nbsp = '␣'
}

vim.opt.scrolloff = 10
vim.opt.cursorline = true

vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

vim.g.netrw_keepdir = 1

