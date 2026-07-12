-- neovim native な機能もしくはその組み合わせで実現可能な keymap を配置する

-- general
vim.api.nvim_set_keymap("i", "jj", "<Esc>", {})
vim.api.nvim_create_user_command("Q", "qa!", {})
vim.api.nvim_create_user_command("CLAUDE", "term claude", {})
vim.api.nvim_create_user_command("CL", "term claude", {})
vim.api.nvim_set_keymap("n", "<leader>n", ":bnext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>N", ":bprevious<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "vv", "<C-v>", {})
-- vim.api.nvim_set_keymap("t", "hj", "<C-\\><C-n>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "JJ", "<C-\\><C-n>", { noremap = true, silent = true })

-- bracket
vim.api.nvim_set_keymap("i", "{", "{}<Left>", {})
vim.api.nvim_set_keymap("i", "{}", "{}", {})
vim.api.nvim_set_keymap("i", "{<Enter>", "{}<Left><CR><ESC><S-o>", {})
vim.api.nvim_set_keymap("i", "(", "()<ESC>i", {})
vim.api.nvim_set_keymap("i", "()", "()", {})
vim.api.nvim_set_keymap("i", "(<Enter>", "()<Left><CR><ESC><S-o>", {})

-- quotes
vim.api.nvim_set_keymap("i", '"', '""<Left>', { noremap = true })
vim.api.nvim_set_keymap("i", '""', '""', { noremap = true })
vim.api.nvim_set_keymap("i", "'", "''<Left>", { noremap = true })
vim.api.nvim_set_keymap("i", "''", "''", { noremap = true })

-- focus window
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })

-- ビジュアルモードでペースト時に上書きした文字をレジスタに入れない
vim.keymap.set("x", "p", '"_dP', { noremap = true, silent = true })

-- disable macro recording
vim.api.nvim_set_keymap("n", "q", "<Nop>", { noremap = true, silent = true })

-- window zoom toggle
vim.keymap.set("n", "<leader>z", function()
  if vim.fn.winnr("$") == 1 then
    vim.cmd("tab close")
  else
    vim.cmd("tab split")
  end
end, { desc = "Toggle window zoom", noremap = true, silent = true })

-- 補完を enter で確定する
vim.api.nvim_set_keymap("i", "<CR>", 'pumvisible() ? "\\<C-y>" : "\\<CR>"', { noremap = true, expr = true })

-- 現在のファイルと行番号をGitHubで開く
vim.keymap.set("n", "<leader>go", function()
  local file = vim.fn.expand("%:.")
  local line = vim.fn.line(".")
  vim.fn.system('gh browse "' .. file .. ":" .. line .. '"')
end, { desc = "Open current line in GitHub" })

vim.keymap.set("v", "<leader>go", function()
  local file = vim.fn.expand("%:.")
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")
  local line_range = start_line == end_line and tostring(start_line) or (start_line .. "-" .. end_line)
  vim.fn.system('gh browse "' .. file .. ":" .. line_range .. '"')
end, { desc = "Open selected range in GitHub" })

-- 現在行を最後に変更したPRをブラウザで開く
-- git blameでコミットを特定し、GitHub APIでそのコミットに紐づくPRを取得する
local function trace_pr()
  local file = vim.fn.expand("%:p")
  local line = vim.fn.line(".")
  local cwd = vim.fn.expand("%:p:h")

  vim.system({ "git", "blame", "-L", line .. "," .. line, "--porcelain", file }, { cwd = cwd }, function(blame)
    if blame.code ~= 0 then
      vim.schedule(function()
        vim.notify("git blame failed: " .. vim.trim(blame.stderr or ""), vim.log.levels.ERROR)
      end)
      return
    end

    local sha = (blame.stdout or ""):match("^(%x+)")
    if not sha or sha:match("^0+$") then
      vim.schedule(function()
        vim.notify("この行はまだコミットされていません", vim.log.levels.WARN)
      end)
      return
    end

    vim.system(
      { "gh", "api", "repos/{owner}/{repo}/commits/" .. sha .. "/pulls", "--jq", ".[0].html_url" },
      { cwd = cwd },
      function(pr)
        local url = vim.trim(pr.stdout or "")
        vim.schedule(function()
          if pr.code ~= 0 or url == "" or url == "null" then
            -- PRが見つからない場合はコミットページを開く
            vim.notify("PRが見つからないためコミットを開きます: " .. sha:sub(1, 7), vim.log.levels.WARN)
            vim.system({ "gh", "browse", sha }, { cwd = cwd })
            return
          end
          vim.ui.open(url)
        end)
      end
    )
  end)
end

vim.api.nvim_create_user_command("TracePR", trace_pr, {})
vim.keymap.set("n", "<leader>gp", trace_pr, { desc = "Open PR that last changed current line" })

-- jj -> esc
-- for vscode add ↓ keybindings.json
--     {
--         "command": "vscode-neovim.compositeEscape1",
--         "key": "j",
--         "when": "neovim.mode == insert && editorTextFocus",
--         "args": "j"
--     },
