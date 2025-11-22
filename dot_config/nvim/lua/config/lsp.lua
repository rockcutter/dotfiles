vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('my.lsp', {}),
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

		local opts = { buffer = args.buf }

		if client:supports_method('textDocument/declaration') then
			vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
		end

		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
		vim.keymap.set('n', '<leader>k', vim.lsp.buf.hover, opts)
		-- vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
		-- vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)

		if client:supports_method('textDocument/implementation') then
			vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
		end

		-- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
		if client:supports_method('textDocument/completion') then
			-- Optional: trigger autocompletion on EVERY keypress. May be slow!
			-- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
			-- client.server_capabilities.completionProvider.triggerCharacters = chars

			vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
		end

		-- Auto-format ("lint") on save.
		-- Usually not needed if server supports "textDocument/willSaveWaitUntil".
		if not client:supports_method('textDocument/willSaveWaitUntil')
			and client:supports_method('textDocument/formatting') then
			vim.api.nvim_create_autocmd('BufWritePre', {
				group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
				buffer = args.buf,
				callback = function()
					vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
				end,
			})
		end
	end,
})

vim.lsp.config["lua_ls"] = {
	cmd = { "lua-language-server" },
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = { vim.env.VIMRUNTIME }
			},
		},
	},
}

vim.lsp.enable({
	"lua_ls",
})
