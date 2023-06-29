return {
	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"jayp0521/mason-null-ls.nvim",
		},
		build = "npm install -g @prettier/plugin-ruby prettier-plugin-erb",
		config = function()
			local mason_null_ls = require("mason-null-ls")
			mason_null_ls.setup({
				-- list of formatters & linters for mason to install
				ensure_installed = {
					"eslint_d",
					"prettierd",
					"stylua",
					"standardrb",
				},
				-- auto-install configured formatters & linters (with null-ls)
				automatic_installation = true,
			})

			local null_ls = require("null-ls")
			local formatting = null_ls.builtins.formatting -- to setup formatters
			local diagnostics = null_ls.builtins.diagnostics -- to setup linters
			local code_actions = null_ls.builtins.code_actions -- to setup code actions

			-- to setup format on save
			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

			null_ls.setup({
				debug = true,
				sources = {
					diagnostics.standardrb,
					formatting.prettierd.with({
						extra_filetypes = { "eruby" },
					}),
					formatting.gofmt,
					formatting.stylua,
					formatting.standardrb,
				},
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
		end,
	},
}
