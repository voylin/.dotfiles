return {
	'nvim-mini/mini.nvim',
	config = function()
		local statusline = require 'mini.statusline'
		statusline.setup { use_icons = true }
		statusline.section_location = function() return '%2l:%-2v' end
	end,
}
