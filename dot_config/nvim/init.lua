-- native settings
vim.g.mapleader = " "
vim.g.editorconfig = true

vim.opt.mouse = ""
vim.opt.number = true
vim.opt.autoread = true
vim.opt.scrolloff = 20
vim.opt.clipboard = "unnamedplus"
vim.opt.splitright = true
vim.opt.updatetime = 500

vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.softtabstop = -1 -- tabstop に従わせる
vim.opt.shiftwidth = 0   -- tabstop に従わせる

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

require("keymap")
require("config.lazy")
require("config.lsp")
require("telescope_keymap")

-- airline
vim.g["airline#extensions#tabline#enabled"] = 1
vim.g["airline#extensions#tabline#formatter"] = "unique_tail_improved"

-- choose random theme
require("random_colorscheme")
