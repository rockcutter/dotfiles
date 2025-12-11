return {
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
}
