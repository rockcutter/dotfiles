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

vim.api.nvim_set_keymap("t", "jj", "<C-\\><C-n>", { noremap = true, silent = true })

-- buffer navigation
vim.api.nvim_set_keymap("n", "<leader>n", ":bnext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>p", ":bprevious<CR>", { noremap = true, silent = true })

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
vim.api.nvim_set_keymap("n", "<C-t>", ":FloatermToggle<CR>", { noremap = true, silent = true }) vim.api.nvim_set_keymap("t", "<C-t>", "<Cmd>FloatermToggle<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>t", ":FloatermToggle<CR>", { noremap = true, silent = true }) vim.api.nvim_set_keymap("t", "<C-t>", "<Cmd>FloatermToggle<CR>", { noremap = true, silent = true })

-- telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-p>", function()
	builtin.find_files({ hidden = true })
end, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>p", function()
	builtin.find_files({ hidden = true })
end, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>ff", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })

