function choose_random_theme(theme_list)
	math.randomseed(os.time())
	return theme_list[math.random(#theme_list)]
end

choosed_theme = choose_random_theme({
	"tokyonight-moon",
	"tokyonight-storm",
	"tokyonight-night",
	--'deus',
	"gruvbox",
	"ayu",
	"ayu-dark",
	"ayu-mirage",
	"everforest",
})

vim.cmd("colorscheme " .. choosed_theme)
