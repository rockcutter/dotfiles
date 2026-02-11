vim.api.nvim_create_autocmd("VimResized", {
	pattern = "*",
	callback = function()
		local claude_win = nil
		for _, win in ipairs(vim.api.nvim_list_wins()) do
			local buf = vim.api.nvim_win_get_buf(win)
			local buf_name = vim.api.nvim_buf_get_name(buf)
			local buf_type = vim.api.nvim_buf_get_option(buf, "buftype")

			if buf_type == "terminal" and buf_name:match("claude") then
				claude_win = win
				break
			end
		end

		if claude_win then
			vim.api.nvim_win_set_width(claude_win, math.floor(vim.o.columns * 0.3))
		end

		vim.cmd("wincmd =")
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
