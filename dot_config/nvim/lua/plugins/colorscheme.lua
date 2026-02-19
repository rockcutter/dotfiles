return {
	{
		"ajmwagar/vim-deus",
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
	},
	{
		"morhetz/gruvbox",
	},
	{
		"Shatur/neovim-ayu",
	},
	{
		"neanias/everforest-nvim",
		version = false,
		lazy = false,
		config = function()
			require("everforest").setup({
				-- Your config here
			})
		end,
	},
}
