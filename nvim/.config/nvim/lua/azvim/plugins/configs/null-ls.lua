local M = {}

M.setup = function()
	local null_ls = require("null-ls")
	require("mason-null-ls").setup({
		ensure_installed = {
			"prettierd",
			"stylua",
		},
		automatic_installation = true,
		handlers = {
			prettierd = function()
				null_ls.register(null_ls.builtins.formatting.prettierd.with({
					extra_filetypes = { "eruby" },
				}))
			end,
		},
	})

	-- to setup format on save
	local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

	null_ls.setup({
		debug = true,
		-- configure format on save
		on_attach = function(current_client, bufnr)
			if current_client.supports_method("textDocument/formatting") then
				vim.api.nvim_clear_autocmds({
					group = augroup,
					buffer = bufnr,
				})
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.format({
							filter = function(client)
								--  only use null-ls for formatting instead of lsp server
								return client.name == "null-ls"
							end,
							bufnr = bufnr,
							timeout_ms = 10000,
						})
					end,
				})
			end
		end,
	})
end

return M
