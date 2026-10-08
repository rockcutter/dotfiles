-- claudeターミナルのウィンドウを探す
local function find_claude_terminal_win()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		local buf_name = vim.api.nvim_buf_get_name(buf)
		local buf_type = vim.bo[buf].buftype
		if buf_type == "terminal" and buf_name:match("claude") then
			return win
		end
	end
	return nil
end

local last_equalized_layout

local function window_layout_signature()
	local layout = { vim.api.nvim_get_current_tabpage(), vim.o.columns, vim.o.lines }
	for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
		if vim.api.nvim_win_get_config(win).relative == "" then
			layout[#layout + 1] = {
				win,
				vim.api.nvim_win_get_position(win),
				vim.api.nvim_win_get_width(win),
				vim.api.nvim_win_get_height(win),
			}
		end
	end
	return vim.json.encode(layout)
end

-- 配置やサイズが変わった場合に均等化する。
-- 同じ配置でのペイン移動では、端末の不要なサイズ変更を避ける。
vim.api.nvim_create_autocmd("WinEnter", {
	callback = function()
		if window_layout_signature() == last_equalized_layout then
			return
		end
		vim.cmd("wincmd =")
		last_equalized_layout = window_layout_signature()
	end,
})

-- 外部でファイルが変更されたら自動的にリロード
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
	pattern = "*",
	callback = function()
		if vim.fn.mode() ~= "c" then
			vim.cmd("checktime")
		end
	end,
})

-- claude ターミナルに入ったとき自動的にノーマルモードに切り替え
vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, {
	pattern = "term://*",
	callback = function()
		local bufname = vim.api.nvim_buf_get_name(0)

		-- バッファ名に "claude" が含まれている場合のみstopinsert
		if bufname:lower():match("claude") then
			vim.schedule(function()
				vim.cmd("stopinsert")
			end)
		end
	end,
})

-- 保存時にtrailing whitespaceを自動削除
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function()
		local pos = vim.api.nvim_win_get_cursor(0)
		vim.cmd([[%s/\s\+$//e]])
		vim.api.nvim_win_set_cursor(0, pos)
	end,
})

vim.api.nvim_create_autocmd("VimResized", {
	pattern = "*",
	callback = function()
		vim.cmd("wincmd =")
		local claude_win = find_claude_terminal_win()
		if claude_win then
			vim.api.nvim_win_set_width(claude_win, math.floor(vim.o.columns * 0.3))
		end
	end,
})
