return {
	{
		"vim-airline/vim-airline",
		airline_powerline_fonts = 1,
	},
	{
		"prabirshrestha/vim-lsp",
	},
	{
		"github/copilot.vim",
	},
	{
		"airblade/vim-gitgutter",
	},
	{
		"mattn/vim-lsp-settings",
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"coder/claudecode.nvim",
		dependencies = { "folke/snacks.nvim" },
		config = true,
		lazy = false,
		opts = {
			auto_start = true,
		},
		keys = {
			{ "<leader>clo", "<cmd>ClaudeCode<cr>", mode = "n", desc = "Open Claude Code" },
			{ "<leader>cls", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
		},
	},
	{
		"voldikss/vim-floaterm",
		config = function()
			vim.g.floaterm_width = 0.95   -- 幅：画面の90%
			vim.g.floaterm_height = 0.95  -- 高さ：画面の90%
		end,
	},
	{
		"tpope/vim-surround",
	},
}
