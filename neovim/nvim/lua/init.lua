require("~/.config/nvim/prep_lazy")

require("~/.config/nvim/plugin")

-- airline
vim.g['airline#extensions#tabline#enabled'] = 1

-- choose random theme
require("~/.config/nvim/random_colorscheme")

-- etc setting
vim.cmd('set number')

-- tab -> 4 space
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

require('~/.config/nvim/keymap')

