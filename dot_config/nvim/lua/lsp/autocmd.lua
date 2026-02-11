vim.api.nvim_create_autocmd("LspDetach", {
	group = vim.api.nvim_create_augroup("my.lsp.detach", {}),
	callback = function(args)
		vim.lsp.completion.enable(false, args.data.client_id, args.buf)
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("my.lsp", {}),
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
		local opts = { buffer = args.buf }

		-- Setup signature help
		require("lsp_signature").on_attach({
			bind = true,
			handler_opts = {
				border = "rounded",
			},
			hint_enable = false,
			floating_window = true,
			toggle_key = "<C-k>",
		}, args.buf)

		if client:supports_method("textDocument/declaration") then
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		end

		vim.keymap.set("n", "gd", function()
			require("telescope.builtin").lsp_definitions()
		end, opts)
		vim.keymap.set("n", "<leader>k", function()
			vim.lsp.buf.hover({ border = "rounded" })
		end, opts)
		-- vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
		vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, opts)
		-- vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)

		-- Document highlight on cursor hold
		if client:supports_method("textDocument/documentHighlight") then
			vim.api.nvim_create_autocmd("CursorHold", {
				buffer = args.buf,
				callback = function()
					vim.lsp.buf.document_highlight()
				end,
			})

			vim.api.nvim_create_autocmd("CursorMoved", {
				buffer = args.buf,
				callback = function()
					vim.lsp.buf.clear_references()
				end,
			})
		end

		if client:supports_method("textDocument/implementation") then
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		end

		if client:supports_method("textDocument/completion") then
			local chars = {}
			for i = 32, 126 do
				table.insert(chars, string.char(i))
			end
			client.server_capabilities.completionProvider.triggerCharacters = chars
			vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
		end

		-- Auto-format ("lint") on save.
		if
			not client:supports_method("textDocument/willSaveWaitUntil")
			and client:supports_method("textDocument/formatting")
		then
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = vim.api.nvim_create_augroup("my.lsp", { clear = false }),
				buffer = args.buf,
				callback = function()
					-- Goファイルはvim-goのgoimportsに任せる
					if vim.bo[args.buf].filetype == "go" then
						return
					end
					vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
				end,
			})
		end
	end,
})
