return {
	'mfussenegger/nvim-dap',
	dependencies = {
		'williamboman/mason.nvim',
		'nvim-neotest/nvim-nio',
	},
	config = function()
		local dap = require('dap')

		-- Debugging keymaps
		vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Debug: Toggle breakpoint' })
		vim.keymap.set('n', '<leader><F5>', dap.continue, { desc = 'Debug: Start/Continue' })
		vim.keymap.set('n', '<F7>', dap.step_over, { desc = 'Debug: Step over' })
		vim.keymap.set('n', '<F8>', dap.step_into, { desc = 'Debug: Step into' })
		vim.keymap.set('n', '<F9>', dap.step_out, { desc = 'Debug: Step out' })
		vim.keymap.set('n', '<F6>', function () dap.terminate() end, { desc = 'Debug: Terminate' })

		-- Godot stuff
		dap.adapters.godot = {
			type = 'server',
			host = '127.0.0.1',
			port = 6007,
		}

		dap.configurations.gdscript = { {
			type = 'godot',
			request = 'launch',
			name = 'Launch scene',
			project = '${workspaceFolder}/src',
			launch_scene = true,
		} }
	end,
}
