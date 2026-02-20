return {
	'saghen/blink.cmp',
	event = 'VimEnter',
	version = '*',
	dependencies = { 'L3MON4D3/LuaSnip' },
	opts = {
		keymap = { preset = 'enter', ['<Tab>'] = { 'accept', 'fallback' } },
		completion = { documentation = { auto_show = true } },
		sources = { default = { 'lsp', 'path', 'buffer', 'snippets' } },
		snippets = { preset = 'luasnip' },
		signature = { enabled = true },
	},
}
