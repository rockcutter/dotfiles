return {
	{
		"mason-org/mason.nvim",
		opts = {},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "mason-org/mason.nvim" },
		opts = {
			ensure_installed = {
				"lua_ls",
				"stylua",
				"gopls",
			},
		},
	},
	{
		"fatih/vim-go",
	},
	{
		"vim-airline/vim-airline",
		airline_powerline_fonts = 1,
	},
	{
		"github/copilot.vim",
	},
	{
		"airblade/vim-gitgutter",
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
			vim.g.floaterm_width = 0.95 -- 幅：画面の90%
			vim.g.floaterm_height = 0.95 -- 高さ：画面の90%
		end,
	},
	{
		"tpope/vim-surround",
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
	},
}
