-- 軽量Neovim設定（fc/FCEDIT用）

-- 基本オプション
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.clipboard = "unnamedplus"

-- カラースキーム（Neovimビルトイン）
vim.cmd.colorscheme("habamax") -- モダンでダーク系のビルトインテーマ

-- キーマップ
vim.api.nvim_set_keymap("i", "jj", "<Esc>", {})
vim.api.nvim_set_keymap("n", "vv", "<C-v>", {})
vim.api.nvim_set_keymap("n", "q", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_create_user_command("Q", "qa!", {})
vim.keymap.set("x", "p", '"_dP', { noremap = true, silent = true })
