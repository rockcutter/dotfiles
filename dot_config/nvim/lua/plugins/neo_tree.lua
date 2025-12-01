return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		lazy = false,
		opts = {
			window = {
				width = 100,
				position = "left",
			},
			filesystem = {
				hijack_netrw_behavior = "open_default",
				filtered_items = {
					visible = false,
					hide_dotfiles = false,
					hide_gitignored = true,
				},
			},
			default_component_configs = {
				indent = {
					with_expanders = true,
				},
			},
		},
		config = function(_, opts)
			require("neo-tree").setup(opts)

			-- フォーカスに応じて幅を変更
			vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter" }, {
				callback = function()
					if vim.bo.filetype == "neo-tree" then
						vim.cmd("vertical resize 100")
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
		end,
	},
}
