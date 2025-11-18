vim.g.mapleader = " "

require("prep_lazy")

require("plugin")

-- airline
vim.g["airline#extensions#tabline#enabled"] = 1
vim.g["airline#extensions#tabline#formatter"] = "unique_tail_improved"

-- choose random theme
require("random_colorscheme")

-- etc setting
vim.cmd("set number")

vim.api.nvim_create_autocmd("VimResized", {
  pattern = "*",
  callback = function()
    vim.cmd("wincmd =")
  end,
})


vim.opt.mouse = ""
vim.opt.clipboard = "unnamedplus"

vim.opt.splitright = true

-- tab -> 4 space
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

require("keymap")

-- telescope
require("prep_telescope")

