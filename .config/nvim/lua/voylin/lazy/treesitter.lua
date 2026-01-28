return {
	'nvim-treesitter/nvim-treesitter',
	build = ':TSUpdate',
	dependencies = {
		'nvim-treesitter/nvim-treesitter-textobjects',
		'nvim-treesitter/playground',

		{
			"nvim-treesitter/nvim-treesitter-context",
			opts = {
				max_lines = 3,
				trim_scope = "inner",
				mode = "cursor",
			},
		}
	},
	config = function()
		require('nvim-treesitter.configs').setup({
			ensure_installed = {
				'c',
				'cpp',
				'zig',
				'lua',
				'vim',
				'rust',
				'yaml',
				'query',
				'vimdoc',
				'markdown',
				'gdscript',
				'gdshader',
				'godot_resource',
			},
			sync_install = false,
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = {
					'yaml',
					'markdown',
				},
			},
			indent = {
				enable = true,
			},
			textobjects = {
				move = {
					enable              = true,
					set_jumps           = true,
					goto_next_start     = { ["]]"] = "@function.outer" },
					goto_next_end       = { ["]m"] = "@function.outer" },
					goto_previous_start = { ["[["] = "@function.outer" },
					goto_previous_end   = { ["[m"] = "@function.outer" },
				},
			},
		})
	end,
}
