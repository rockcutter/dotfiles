-- native settings
vim.g.mapleader = " "
vim.g.editorconfig = true

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

vim.o.laststatus = 3
vim.opt.list = true
vim.opt.listchars = {
  space = "·",
  trail = "·",
  tab = "  ",
}

vim.api.nvim_create_autocmd("VimResized", {
  pattern = "*",
  callback = function()
    local claude_win = nil
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local buf = vim.api.nvim_win_get_buf(win)
      local buf_name = vim.api.nvim_buf_get_name(buf)
      local buf_type = vim.api.nvim_buf_get_option(buf, "buftype")

      if buf_type == "terminal" and buf_name:match("claude") then
        claude_win = win
        break
      end
    end

    if claude_win then
      vim.api.nvim_win_set_width(claude_win, math.floor(vim.o.columns * 0.3))
    end

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
