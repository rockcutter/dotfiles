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
				"terraformls",
				"graphql",
				"ts_ls",
			},
		},
	},
	{
		"fatih/vim-go",
		init = function()
			-- vim-goのデフォルトキーマッピングを無効化
			vim.g.go_def_mapping_enabled = 0
		end,
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
		opts = {
			diff_opts = {
				vertical_split = false,
				open_in_current_tab = false,
			},
		},
		keys = {
			{ "<leader>clo", "<cmd>ClaudeCode<cr>", mode = "n", desc = "Open Claude Code" },
			{ "<leader>cls", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
		},
	},
	{
		"voldikss/vim-floaterm",
		config = function()
			vim.g.floaterm_width = 0.95
			vim.g.floaterm_height = 0.95
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
