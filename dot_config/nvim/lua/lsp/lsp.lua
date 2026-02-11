vim.opt.completeopt = { "noselect", "menuone", "popup" }

vim.diagnostic.config({
	virtual_lines = true,
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = true,
	},
})

vim.lsp.config["lua_ls"] = {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = { vim.env.VIMRUNTIME },
			},
		},
	},
}

vim.lsp.config["gopls"] = {
	cmd = { "gopls" },
	filetypes = { "go", "gomod" },
	root_markers = { "go.mod" },
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
				shadow = true,
			},
			staticcheck = true,
			gofumpt = true,
		},
	},
}

vim.lsp.config["graphql"] = {
	cmd = { "graphql-lsp", "server", "-m", "stream" },
	filetypes = { "graphql" },
}

vim.lsp.config["ts_ls"] = {
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	root_markers = { "package.json", "tsconfig.json", "jsconfig.json" },
}

vim.lsp.config["clangd"] = {
	cmd = { "clangd", "--background-index" },
	filetypes = { "c", "cpp", "h", "hpp" },
}

vim.lsp.enable({
	"lua_ls",
	"gopls",
	"graphql",
	"ts_ls",
	"clangd",
})
