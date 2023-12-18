-- keymap

-- blockwise-visual modk
vim.api.nvim_set_keymap('n', 'vv', '<C-v>', {})

-- bracket
vim.api.nvim_set_keymap('i', '{', '{}<Left>', {})
vim.api.nvim_set_keymap('i', '{}', '{}', {})
vim.api.nvim_set_keymap('i', '{<Enter>', '{}<Left><CR><ESC><S-o>', {})
vim.api.nvim_set_keymap('i', '(', '()<ESC>i', {})
vim.api.nvim_set_keymap('i', '()', '()', {})
vim.api.nvim_set_keymap('i', '(<Enter>', '()<Left><CR><ESC><S-o>', {})

-- jj -> esc
vim.api.nvim_set_keymap('i', 'jj', '<Esc>', {})

-- leader
vim.g.mapleader = " "
vim.api.nvim_set_keymap('n', '<Leader>k', ':q', {})

-- Q
vim.api.nvim_create_user_command('Q', 'qa!' ,{})

-- easy motion
vim.api.nvim_set_keymap("n", "<Leader>l", "<Plug>(easymotion-overwin-f)", {})
vim.api.nvim_set_keymap("n", "<Leader>j", "<Plug>(easymotion-j)", {})
vim.api.nvim_set_keymap("n", "<Leader>k", "<Plug>(easymotion-k)", {})
