return {
	'nvim-treesitter/nvim-treesitter',
	build = ':TSUpdate',
	config = function()
		require('nvim-treesitter.configs').setup({
			ensure_installed = {
				'rust',
				'gdscript',
				'godot_resource',
				'gdshader',
				'cpp',
				'c',
				'lua',
				'vim',
				'vimdoc',
				'query'
			},
			sync_install = false,
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = { 'markdown' },
			},
			indent = {
				enable = true,
			},
		})
	end,
}
