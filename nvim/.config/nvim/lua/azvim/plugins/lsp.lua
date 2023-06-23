return {
	"neovim/nvim-lspconfig",
	event = "BufReadPre",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"jayp0521/mason-null-ls.nvim",
		"jose-elias-alvarez/null-ls.nvim",
		"jose-elias-alvarez/typescript.nvim",
	},
	cmd = {
		"Mason",
	},
	config = function()
		-- MASON
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_null_ls = require("mason-null-ls")
		local util = require("lspconfig/util")
		mason.setup()

		mason_lspconfig.setup({
			-- list of servers for mason to install
			ensure_installed = {
				"gopls",
				"jsonls",
				"lua_ls",
				"tailwindcss",
				"terraformls",
				"tsserver",
				"yamlls",
				"solargraph",
			},
			-- auto-install configured servers (with lspconfig)
			automatic_installation = true, -- not the same as ensure_installed
		})

		mason_null_ls.setup({
			-- list of formatters & linters for mason to install
			ensure_installed = {
				"eslint_d", -- ts/js linter
				"stylua", -- lua formatter
				"tflint", -- terraform linter
				"yamllint", -- yaml linter
				"prettierd",
			},
			-- auto-install configured formatters & linters (with null-ls)
			automatic_installation = true,
		})

		-- LSP CONFIG
		local lspconfig = require("lspconfig")
		local typescript = require("typescript")

		local keymap = vim.keymap

		-- enable keybinds only for when lsp server available
		local on_attach = function(client, bufnr)
			-- keybind options
			local opts = { noremap = true, silent = true, buffer = bufnr }

			local nmap = function(keys, func, desc)
				if desc then
					desc = "LSP: " .. desc
				end

				vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
			end

			-- set keybinds
			keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
			keymap.set("n", "gf", "<cmd>Telescope lsp_references<CR>", opts)
			keymap.set("n", "K", vim.lsp.buf.hover, opts)
			keymap.set("n", "<leader>la", vim.lsp.buf.code_action, opts)
			nmap("<leader>lf", function()
				vim.lsp.buf.format({ timeout_ms = 10000 })
			end, "[F]ormat")
			keymap.set("n", "<leader>lj", vim.diagnostic.goto_next, opts)
			keymap.set("n", "<leader>lk", vim.diagnostic.goto_prev, opts)
			keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)
			keymap.set("n", "<leader>lq", "<cmd>LspRestart<CR>", opts)

			-- typescript specific keymaps (e.g. rename file and update imports)
			if client.name == "tsserver" then
				keymap.set("n", "<leader>lo", "<cmd>TypescriptOrganizeImports<CR>", opts)
				keymap.set("n", "<leader>li", "<cmd>TypescriptAddMissingImports<CR>", opts)
				keymap.set("n", "<leader>lrf", "<cmd>TypescriptRenameFile<CR>", opts)
				keymap.set("n", "<leader>lu", "<cmd>TypescriptRemoveUnused<CR>", opts)
			end
		end

		-- Change the Diagnostic symbols in the sign column (gutter)
		local signs = { Error = " ", Warn = " ", Hint = "ﴞ ", Info = " " }

		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type

			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		-- configure typescript server with plugin
		typescript.setup({
			server = {
				on_attach = on_attach,
			},
		})

		lspconfig["gopls"].setup({
			on_attach = on_attach,
			cmd = { "gopls" },
			filetypes = { "go", "gomod", "gowork", "gotmpl" },
			root_dir = util.root_pattern("go.work", "go.mod", ".git"),
			settings = {
				gopls = {
					completeUnimported = true,
					usePlaceholders = true,
				},
			},
		})

		lspconfig["yamlls"].setup({
			server = {
				on_attach = on_attach,
			},
		})

		lspconfig["jsonls"].setup({
			server = {
				on_attach = on_attach,
			},
		})

		lspconfig["solargraph"].setup({
			server = {
				on_attach = on_attach,
			},
		})

		lspconfig["terraformls"].setup({
			server = {
				on_attach = on_attach,
			},
		})

		-- configure tailwind
		lspconfig["tailwindcss"].setup({
			on_attach = on_attach,
			settings = {
				tailwindCSS = {
					experimental = {
						classRegex = {
							"cva\\(([^)]*)\\)",
							"[\"'`]([^\"'`]*).*?[\"'`]",
						},
					},
				},
			},
		})

		-- configure lua server (with special settings)
		lspconfig["lua_ls"].setup({
			on_attach = on_attach,
			settings = { -- custom settings for lua
				Lua = {
					-- make the language server recognize "vim" global
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						-- make language server aware of runtime files
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
				},
			},
		})

		-- NULL LS
		local null_ls = require("null-ls")
		local formatting = null_ls.builtins.formatting -- to setup formatters
		local diagnostics = null_ls.builtins.diagnostics -- to setup linters
		local code_actions = null_ls.builtins.code_actions -- to setup code actions

		-- to setup format on save
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

		-- configure null_ls
		null_ls.setup({
			-- setup formatters & linters
			sources = {
				formatting.prettierd,
				formatting.eslint_d,
				formatting.gofmt,
				formatting.stylua,
				formatting.terraform_fmt,
				diagnostics.eslint_d,
				diagnostics.markdownlint,
				diagnostics.yamllint,
				code_actions.eslint_d,
				code_actions.gitrebase,
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
}
