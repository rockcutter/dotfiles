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

vim.api.nvim_set_keymap('t', '<C-h>', '<C-\\><C-n><C-w>h', { desc = 'Move to left pane' })
vim.api.nvim_set_keymap('t', '<C-j>', '<C-\\><C-n><C-w>j', { desc = 'Move to bottom pane' })
vim.api.nvim_set_keymap('t', '<C-k>', '<C-\\><C-n><C-w>k', { desc = 'Move to top pane' })
vim.api.nvim_set_keymap('t', '<C-l>', '<C-\\><C-n><C-w>l', { desc = 'Move to right pane' })

-- jj -> esc
-- for vscode add ↓ keybindings.json
--     {
--         "command": "vscode-neovim.compositeEscape1",
--         "key": "j",
--         "when": "neovim.mode == insert && editorTextFocus",
--         "args": "j"
--     },
vim.api.nvim_set_keymap("i", "jj", "<Esc>", {})

-- leader
vim.g.mapleader = " "
vim.api.nvim_set_keymap("n", "<Leader>k", ":q", {})

-- Q
vim.api.nvim_create_user_command("Q", "qa!", {})

-- vsplit | term 
vim.api.nvim_create_user_command("VT", "vsplit | term", {})

-- floaterm
vim.api.nvim_set_keymap("n", "<C-t>", ":FloatermToggle<CR>", { noremap = true, silent = true }) vim.api.nvim_set_keymap("t", "<C-t>", "<Cmd>FloatermToggle<CR>", { noremap = true, silent = true })

-- telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-p>", function()
	builtin.find_files({ hidden = true })
end, { desc = "Telescope find files" })
