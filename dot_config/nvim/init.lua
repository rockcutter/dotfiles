-- native settings
vim.g.mapleader = " "
vim.g.editorconfig = true

vim.opt.scrolloff = 10
vim.opt.mouse = ""
vim.opt.clipboard = "unnamedplus"
vim.opt.autoread = true
vim.opt.splitright = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.api.nvim_create_autocmd("VimResized", {
	pattern = "*",
	callback = function()
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

-- etc setting
vim.opt.number = true

require("keymap")
require("config.lazy")
require("config.lsp")

-- airline
vim.g["airline#extensions#tabline#enabled"] = 1
vim.g["airline#extensions#tabline#formatter"] = "unique_tail_improved"

-- choose random theme
require("random_colorscheme")
