return {
	'nvim-telescope/telescope.nvim',
	dependencies = {
		'nvim-lua/plenary.nvim',
		{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
	},
	config = function()
		pcall(require('telescope').load_extension, 'fzf')
		local builtin = require('telescope.builtin')
		local ivy = require('telescope.themes').get_ivy({
			layout_config = {
				preview_cutoff = 60,
				prompt_position = "bottom"
			}
		})
		require('telescope').setup({
			defaults = { file_ignore_patterns = { ".uid", "ffmpeg/", "emsdk" } },
			pickers = { find_files = ivy, git_files = ivy, live_grep = ivy, grep_string = ivy }
		})

		vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
		vim.keymap.set('n', '<leader>pg', builtin.git_files, {})

		vim.keymap.set('n', '<leader>ps', builtin.live_grep)
		vim.keymap.set('n', '<leader>pS', function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end)

		vim.keymap.set('n', '<leader>pws', function()
			local word = vim.fn.expand("<cword>")
			builtin.grep_string({ search = word })
		end)

		vim.keymap.set('n', '<leader>pWs', function()
			local word = vim.fn.expand("<cWORD>")
			builtin.grep_string({ search = word })
		end)
	end
}
