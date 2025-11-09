require("~/.config/nvim/prep_lazy")

require("~/.config/nvim/plugin")

-- airline
vim.g["airline#extensions#tabline#enabled"] = 1

-- choose random theme
require("~/.config/nvim/random_colorscheme")

-- etc setting
vim.cmd("set number")

vim.api.nvim_create_autocmd("VimResized", {
  pattern = "*",
  callback = function()
    vim.cmd("wincmd =")
  end,
})

-- tab -> 4 space
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

require("~/.config/nvim/keymap")

-- telescope
require("telescope").setup({
	defaults = {
		file_ignore_patterns = {
			-- 検索から除外するものを指定
			"^.git/",
			"^.cache/",
			"^.zsh_sessions/",
			"^Library/",
			"Parallels",
			"^Movies",
			"^Music",
			"Dropbox/",
			".DS_Store",
		},
		vimgrep_arguments = {
			-- ripggrepコマンドのオプション
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
			"-uu",
		},
	},
	extensions = {
		-- ソート性能を大幅に向上させるfzfを使う
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
	},
})
require("telescope").load_extension("fzf")
