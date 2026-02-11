-- plugin に依存する keymap をここに書く

-- telescope
local telescope = require("telescope.builtin")

vim.keymap.set("n", "<leader>fr", telescope.lsp_references, { desc = "Telescope find references" })
vim.keymap.set("n", "<leader>fi", telescope.lsp_implementations, { desc = "Telescope find implementations" })
vim.keymap.set("n", "<leader>ff", telescope.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", telescope.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>b", telescope.buffers, { desc = "Telescope buffers" })

vim.keymap.set("n", "<leader>p", function()
	telescope.find_files({ hidden = true })
end, { desc = "Telescope find files" })

vim.keymap.set("n", "gf", function()
	local word = vim.fn.expand("<cfile>")

	-- TODO: terminal という絞り方ではなく floaterm であることを判定する方法を考える
	-- floaterm内の場合は一旦floatermを閉じてからファイルを開く
	-- 閉じないとfloaterm内でファイルが開いてしまうため
	if vim.bo.buftype == "terminal" then
		vim.cmd("FloatermHide")
	end

	telescope.find_files({
		default_text = word,
		hidden = true,
	})
end, { desc = "Find file under cursor with Telescope" })

-- floaterm
vim.api.nvim_set_keymap("n", "<C-t>", ":FloatermToggle<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<C-t>", "<Cmd>FloatermToggle<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>t", ":FloatermToggle<CR>", { noremap = true, silent = true })
