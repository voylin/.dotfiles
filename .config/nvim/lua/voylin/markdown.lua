vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        vim.keymap.set('n', 'j', 'gj', { buffer = true })
        vim.keymap.set('n', 'k', 'gk', { buffer = true })
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
		vim.opt_local.colorcolumn = ""  -- This disables the column line
-- Enable manually with :set spell
--		vim.opt_local.spell = true
        vim.opt_local.spelllang = "en_us"
    end,
})

-- Spelling controls
-- ]s - move to next misspelled word
-- [s - move to previous misspelled word
-- z= - suggest corrections for the word under cursor
-- zg - add word to spell list (good word)
-- zw - mark word as wrong
