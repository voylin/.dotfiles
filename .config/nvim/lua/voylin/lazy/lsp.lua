return {
	'neovim/nvim-lspconfig',
	dependencies = {
		'williamboman/mason.nvim',
		'williamboman/mason-lspconfig.nvim',
		'windwp/nvim-autopairs',
		'L3MON4D3/LuaSnip',
		'j-hui/fidget.nvim',
		'mfussenegger/nvim-jdtls',
	},
	config = function()
		local capabilities = vim.tbl_deep_extend(
			'force',
			{},
			vim.lsp.protocol.make_client_capabilities(),
			require('blink.cmp').get_lsp_capabilities())

		require('fidget').setup({})
		require('mason').setup()
		require('mason-lspconfig').setup({
			ensure_installed = {
				'clangd',
				'lua_ls',
				'rust_analyzer',
				'gopls',
			},
			handlers = {
				function(server_name) -- default handler (optional)
					require('lspconfig')[server_name].setup { capabilities = capabilities }
				end,
			}
		})

		-- Lua
		vim.lsp.config('lua_ls', {
			capabilities = capabilities,
			settings = {
				Lua = {
					runtime = { version = 'Lua 4.1' },
					diagnostics = {
						globals = { 'vim', 'it', 'describe', 'before_each', 'after_each' },
					}
				}
			}
		})

		-- Clangd
		vim.lsp.config('clangd', {
			cmd = {
				"clangd",
				"--header-insertion=never",
			},
			capabilities = capabilities,
		})
		vim.lsp.enable('clangd')

		-- Godot
		vim.lsp.config('gdscript', { capabilities = capabilities })
		vim.lsp.enable('gdscript')
		local godot_project = vim.fn.glob(vim.fn.getcwd() .. '/project.godot')
		if godot_project ~= '' then vim.fn.serverstart '127.0.0.1:6004' end

		-- Diagnostics UI
		vim.diagnostic.config({
			float = {
				focusable = false,
				style = 'minimal',
				border = 'rounded',
				source = 'always',
				header = '',
				prefix = '',
			},
		})
	end
}
