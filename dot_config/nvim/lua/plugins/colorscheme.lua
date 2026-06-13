-- 起動時にランダムでテーマを選び、そのテーマのプラグインだけ即ロードして適用する
-- 他プラグインのColorScheme autocmd登録前に適用しないと起動が遅くなるため、
-- priority = 1000 で最優先ロードする（lazy.nvim公式推奨パターン）
-- 選ばれなかったテーマは lazy = true でも :colorscheme 実行時に自動ロードされる
local candidates = {
	--- { "tokyonight-moon", "tokyonight.nvim" },
	{ "tokyonight-storm", "tokyonight.nvim" },
	{ "tokyonight-night", "tokyonight.nvim" },
	--- { "deus", "vim-deus" },
	{ "gruvbox", "gruvbox" },
	{ "ayu", "neovim-ayu" },
	{ "ayu-dark", "neovim-ayu" },
	{ "ayu-mirage", "neovim-ayu" },
	{ "everforest", "everforest-nvim" },
}

math.randomseed(os.time())
local chosen = candidates[math.random(#candidates)]
local chosen_colorscheme, chosen_plugin = chosen[1], chosen[2]

-- 選ばれたテーマのプラグインだけ即ロードに切り替え、ロード後にcolorschemeを適用する
local function theme_spec(spec)
	local plugin_name = spec[1]:match("[^/]+$")
	if plugin_name ~= chosen_plugin then
		spec.lazy = true
		return spec
	end

	spec.lazy = false
	spec.priority = 1000
	local config = spec.config
	spec.config = function(...)
		if config then
			config(...)
		end
		vim.cmd.colorscheme(chosen_colorscheme)
	end
	return spec
end

return {
	theme_spec({
		"ajmwagar/vim-deus",
	}),
	theme_spec({
		"folke/tokyonight.nvim",
	}),
	theme_spec({
		"morhetz/gruvbox",
	}),
	theme_spec({
		"Shatur/neovim-ayu",
	}),
	theme_spec({
		"neanias/everforest-nvim",
		version = false,
		config = function()
			require("everforest").setup({
				-- Your config here
			})
		end,
	}),
}
