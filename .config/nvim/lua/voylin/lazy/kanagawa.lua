return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
 		require('catppuccin').setup({})
 		vim.cmd('colorscheme catppuccin-frappe')

		local is_dark_mode = true
		function ToggleTheme()
			if is_dark_mode then
				vim.cmd('colorscheme catppuccin-latte') -- Light theme
				is_dark_mode = false
			else
				vim.cmd('colorscheme catppuccin-frappe')  -- Dark theme
				is_dark_mode = true
			end
		end

		-- Map a keybinding to toggle the theme
		vim.api.nvim_set_keymap('n', '<leader>tt', ':lua ToggleTheme()<CR>', { noremap = true, silent = true })
 	end
}
