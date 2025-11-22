vim.g.mapleader = " "
require("config.lazy")
require("config.lsp")

require("keymap")


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

-- 外部でファイルが変更されたら自動的にリロード
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
	pattern = "*",
	callback = function()
		if vim.fn.mode() ~= "c" then
			vim.cmd("checktime")
		end
	end,
})

vim.opt.mouse = ""
vim.opt.clipboard = "unnamedplus"
vim.opt.autoread = true

vim.opt.splitright = true

-- tab -> 4 space
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
