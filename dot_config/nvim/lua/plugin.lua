require("lazy").setup({
	{
		"vim-airline/vim-airline",
		airline_powerline_fonts = 1,
	},
	{
		"prabirshrestha/vim-lsp",
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
-- 	{
-- 		"folke/noice.nvim",
-- 		event = "VeryLazy",
-- 		config = function()
-- 			require("prep_noice")
-- 		end,
-- 		opts = {
-- 			-- add any options here
-- 		},
-- 		dependencies = {
-- 			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
-- 			"MunifTanjim/nui.nvim",
-- 			-- OPTIONAL:
-- 			--   `nvim-notify` is only needed, if you want to use the notification view.
-- 			--   If not available, we use `mini` as the fallback
-- 			"rcarriga/nvim-notify",
-- 		},
-- 	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		filesystem = {
			hijack_netrw_behavior = "open_current",
			filtered_items = {
				visible = false,
				hide_dotfiles = false,
				hide_gitignored = true,
			},
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- Optional image support for file preview: See `# Preview Mode` for more information.
			-- {"3rd/image.nvim", opts = {}},
			-- OR use snacks.nvim's image module:
			-- "folke/snacks.nvim",
		},
		lazy = false, -- neo-tree will lazily load itself
		---@module "neo-tree"
		---@type neotree.Config?
		opts = {
			-- add options here
		},
	},
	{
		"voldikss/vim-floaterm",
	},
	{
		"tpope/vim-surround",
	},

	-- theme
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
})

-- neo-tree
require("neo-tree").setup({
  window = {
    width = 20,
  },

})

-- フォーカスに応じて幅を変更
vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter" }, {
  callback = function()
    if vim.bo.filetype == "neo-tree" then
      vim.cmd("vertical resize 40")
    end
  end,
})

vim.api.nvim_create_autocmd("WinLeave", {
  callback = function()
    if vim.bo.filetype == "neo-tree" then
      vim.cmd("vertical resize 20")
    end
  end,
})
