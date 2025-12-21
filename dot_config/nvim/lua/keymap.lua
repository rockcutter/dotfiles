-- keymap

-- blockwise-visual modk
vim.api.nvim_set_keymap("n", "vv", "<C-v>", {})

-- bracket
vim.api.nvim_set_keymap("i", "{", "{}<Left>", {})
vim.api.nvim_set_keymap("i", "{}", "{}", {})
vim.api.nvim_set_keymap("i", "{<Enter>", "{}<Left><CR><ESC><S-o>", {})
vim.api.nvim_set_keymap("i", "(", "()<ESC>i", {})
vim.api.nvim_set_keymap("i", "()", "()", {})
vim.api.nvim_set_keymap("i", "(<Enter>", "()<Left><CR><ESC><S-o>", {})

-- focus window
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })

-- window zoom toggle
vim.keymap.set("n", "<leader>z", function()
	if vim.fn.winnr("$") == 1 then
		vim.cmd("tab close")
	else
		vim.cmd("tab split")
	end
end, { desc = "Toggle window zoom", noremap = true, silent = true })

vim.api.nvim_set_keymap("t", "jj", "<C-\\><C-n>", { noremap = true, silent = true })

-- buffer navigation
vim.api.nvim_set_keymap("n", "<leader>n", ":bnext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>N", ":bprevious<CR>", { noremap = true, silent = true })

-- jj -> esc
-- for vscode add ↓ keybindings.json
--     {
--         "command": "vscode-neovim.compositeEscape1",
--         "key": "j",
--         "when": "neovim.mode == insert && editorTextFocus",
--         "args": "j"
--     },
vim.api.nvim_set_keymap("i", "jj", "<Esc>", {})

-- Q
vim.api.nvim_create_user_command("Q", "qa!", {})

-- floaterm
vim.api.nvim_set_keymap("n", "<C-t>", ":FloatermToggle<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<C-t>", "<Cmd>FloatermToggle<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>t", ":FloatermToggle<CR>", { noremap = true, silent = true })

-- 補完を enter で確定する
vim.api.nvim_set_keymap("i", "<CR>", 'pumvisible() ? "\\<C-y>" : "\\<CR>"', { noremap = true, expr = true })

-- 現在のファイルと行番号をGitHubで開く
vim.keymap.set("n", "<leader>go", function()
	local file = vim.fn.expand("%:.")
	local line = vim.fn.line(".")
	vim.fn.system('gh browse "' .. file .. ":" .. line .. '"')
end, { desc = "Open current line in GitHub" })

vim.keymap.set("v", "<leader>go", function()
	local file = vim.fn.expand("%:.")
	local start_line = vim.fn.line("'<")
	local end_line = vim.fn.line("'>")
	local line_range = start_line == end_line and tostring(start_line) or (start_line .. "-" .. end_line)
	vim.fn.system('gh browse "' .. file .. ":" .. line_range .. '"')
end, { desc = "Open selected range in GitHub" })

-- disable macro recording
vim.api.nvim_set_keymap("n", "q", "<Nop>", { noremap = true, silent = true })
