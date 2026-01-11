local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>p", function()
	builtin.find_files({ hidden = true })
end, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fr", function()
	builtin.lsp_references()
end, { desc = "Telescope find references" })
vim.keymap.set("n", "<leader>fi", function()
	builtin.lsp_implementations()
end, { desc = "Telescope find implementations" })
vim.keymap.set("n", "<leader>ff", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })

vim.keymap.set("n", "gf", function()
	local word = vim.fn.expand("<cfile>")

	-- TODO: terminal という絞り方ではなく floaterm であることを判定する方法を考える
	-- floaterm内の場合は一旦floatermを閉じてからファイルを開く
	-- 閉じないとfloaterm内でファイルが開いてしまうため
	if vim.bo.buftype == "terminal" then
		vim.cmd("FloatermHide")
	end

	builtin.find_files({
		default_text = word,
		hidden = true,
	})
end, { desc = "Find file under cursor with Telescope" })
