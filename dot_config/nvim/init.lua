-- native settings
vim.g.mapleader = " "
vim.g.editorconfig = true

vim.opt.number = true
vim.opt.autoread = true
vim.opt.scrolloff = 20
vim.opt.clipboard = "unnamedplus"
vim.opt.splitright = true
vim.opt.updatetime = 500
vim.opt.wrap = true

vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.softtabstop = -1 -- tabstop に従わせる
vim.opt.shiftwidth = 0 -- tabstop に従わせる

vim.o.laststatus = 3
vim.opt.list = true
vim.opt.listchars = {
	space = "·",
	trail = "·",
	tab = "  ",
}

-- airline
vim.g["airline#extensions#tabline#enabled"] = 1
vim.g["airline#extensions#tabline#formatter"] = "unique_tail_improved"

require("keymap.native")
require("autocmd")

require("config.lazy")
require("keymap.plugin")

require("lsp.lsp")
require("lsp.autocmd")

-- choose random theme
require("random_colorscheme")

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "<filetype>" },
	callback = function()
		vim.treesitter.start()
	end,
})
