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
				"clangd",
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
		-- dependencies = { "folke/snacks.nvim" },
		config = true,
		opts = {
			terminal = {
				provider = "native",
				split_side = "right",
				split_width_percentage = 0.1,
			},
			diff_opts = {
				vertical_split = false,
				open_in_current_tab = false,
			},
		},
		keys = {
			{ "<leader>cl", "<cmd>ClaudeCode<cr>", mode = "n", desc = "Open Claude Code" },
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
		"junegunn/vim-easy-align",
		config = function()
			vim.keymap.set("x", "<leader>ea", "<Plug>(EasyAlign)", { desc = "Easy Align" })
			vim.keymap.set("n", "<leader>ea", "<Plug>(EasyAlign)", { desc = "Easy Align" })
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
	},
	{
		"ray-x/lsp_signature.nvim",
		event = "LspAttach",
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {
			indent = {
				char = "▏",
				tab_char = "▏",
			},
			whitespace = {
				highlight = { "Whitespace", "NonText" },
			},
		},
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			defaults = {
				file_ignore_patterns = {
					-- 検索から除外するものを指定
					"^.git/",
					"^.cache/",
					"^.zsh_sessions/",
					"^Library/",
					"Parallels",
					"^Movies",
					"^Music",
					"Dropbox/",
					".DS_Store",
					-- report
					"cdk.out",
					".venv",
				},
				vimgrep_arguments = {
					-- ripggrepコマンドのオプション
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
					"-uu",
				},
			},
			extensions = {
				-- ソート性能を大幅に向上させるfzfを使う
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
			},
		},
		config = function(_, opts)
			require("telescope").setup(opts)
			require("telescope").load_extension("fzf")
		end,
	},
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
				follow_current_file = {
					enabled = true,
					leave_dirs_open = false,
				},
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
						local mode = vim.fn.mode()
						-- 検索時に幅が狭くなるのを防ぐ
						if mode ~= "i" then
							vim.cmd("vertical resize 8")
						end
					end
				end,
			})
		end,
	},
}
