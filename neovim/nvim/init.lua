require("prep_lazy")

require("plugin")

-- airline
vim.g["airline#extensions#tabline#enabled"] = 1

-- choose random theme
require("random_colorscheme")

-- etc setting
vim.cmd("set number")
vim.opt.mouse = ""
vim.opt.clipboard = "unnamedplus"

-- tab -> 4 space
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

require("keymap")

-- telescope
require("prep_telescope")

