local M = {}

local data_path = vim.fn.stdpath("data") .. "/haya.json"
local win_id, bufnr = nil, nil

local function load_data()
	local f = io.open(data_path, "r")
	if not f then return {} end
	local content = f:read("*a")
	f:close()
	if content == "" then return {} end
	local ok, data = pcall(vim.json.decode, content)
	return ok and data or {}
end

local function save_data(data)
	local f = io.open(data_path, "w")
	if f then
		f:write(vim.json.encode(data))
		f:close()
	end
end

-- State --

local config_data = load_data()

local function get_list()
	config_data = load_data()
	local cwd = vim.fn.getcwd()
	if not config_data[cwd] then config_data[cwd] = {} end
	return config_data[cwd]
end

local function save_list(list)
	local cwd = vim.fn.getcwd()
	config_data[cwd] = list
	save_data(config_data)
end

-- Core --

function M.add()
	local list = get_list()
	local current_file = vim.fn.expand("%:p")
	if current_file == "" then return end

	-- Make path relative to keep it clean
	local relative_path = vim.fn.fnamemodify(current_file, ":.")

	-- Prevent duplicates
	for _, item in ipairs(list) do
		if item == relative_path then return end
	end

	table.insert(list, relative_path)
	save_list(list)
	print("Haya: " .. relative_path)
end

function M.select(idx)
	local list = get_list()
	local file = list[idx]
	if file and file ~= "" then
		vim.cmd("edit " .. vim.fn.fnameescape(file))
	end
end

-- UI --

local function close_ui()
	if win_id and vim.api.nvim_win_is_valid(win_id) then
		pcall(vim.api.nvim_win_close, win_id, true)
	end
	win_id, bufnr = nil, nil
end

local function save_ui()
	if not bufnr or not vim.api.nvim_buf_is_valid(bufnr) then return end
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
	local new_list = {}
	for _, line in ipairs(lines) do
		-- Skip empty lines when saving
		if line ~= "" then table.insert(new_list, line) end
	end
	save_list(new_list)
end

function M.toggle()
	-- If already open, close and save.
	if win_id and vim.api.nvim_win_is_valid(win_id) then
		save_ui()
		close_ui()
		return
	end

	local list = get_list()
	bufnr = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, list)

	-- Window sizing & positioning.
	local width = math.floor(vim.o.columns * 0.5)
	local height = 7
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	win_id = vim.api.nvim_open_win(bufnr, true, {
		relative = "editor",
		row = row,
		col = col,
		width = width,
		height = height,
		style = "minimal",
		border = "rounded",
		title = " Haya ",
		title_pos = "center"
	})
	vim.bo[bufnr].buftype = "acwrite"
	vim.bo[bufnr].bufhidden = "delete"

	-- UI Keymaps.
	local opts = { buffer = bufnr, silent = true }
	vim.keymap.set('n', 'q', function()
		save_ui(); close_ui()
	end, opts)
	vim.keymap.set('n', '<Esc>', function()
		save_ui(); close_ui()
	end, opts)
	vim.keymap.set('n', '<CR>', function()
		save_ui()
		local idx = vim.fn.line('.')
		close_ui()
		M.select(idx)
	end, opts)

	-- Save on :w.
	vim.api.nvim_create_autocmd("BufWriteCmd", {
		buffer = bufnr,
		callback = function()
			save_ui()
			vim.bo[bufnr].modified = false
		end
	})

	-- Auto-close & save if you leave the window.
	vim.api.nvim_create_autocmd("BufLeave", {
		buffer = bufnr,
		callback = function()
			save_ui()
			close_ui()
		end
	})
end

-- Setup (Keymaps) --
function M.setup()
	vim.keymap.set("n", "<leader>a", M.add)
	vim.keymap.set("n", "<C-e>", M.toggle)
	vim.keymap.set("n", "<C-j>", function() M.select(1) end)
	vim.keymap.set("n", "<C-k>", function() M.select(2) end)
	vim.keymap.set("n", "<C-l>", function() M.select(3) end)
	vim.keymap.set("n", ";;", function() M.select(4) end)
end

return M
