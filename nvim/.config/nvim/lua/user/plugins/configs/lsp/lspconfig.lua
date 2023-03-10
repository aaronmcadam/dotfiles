local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
	return
end

local typescript_setup, typescript = pcall(require, "typescript")
if not typescript_setup then
	return
end

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
	keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts) -- show definition, references
	keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
	keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
	nmap("gT", vim.lsp.buf.type_definition, "[G]oto [T]ype definition")
	nmap("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
	nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
	keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
	keymap.set("n", "<leader>la", "<cmd>Lspsaga code_action<CR>", opts)
	nmap("<leader>lf", function()
		vim.lsp.buf.format({ timeout_ms = 10000 })
	end, "[F]ormat")
	keymap.set("n", "<leader>lj", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
	keymap.set("n", "<leader>lk", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
	keymap.set("n", "<leader>lr", "<cmd>Lspsaga rename<CR>", opts)
	keymap.set("n", "<leader>lq", "<cmd>LspRestart<CR>", opts)
	keymap.set("n", "<leader>ls", "<cmd>Lspsaga signature_help<CR>", opts)
	keymap.set("n", "<leader>lt", "<cmd>LSoutlineToggle<CR>", opts)

	-- typescript specific keymaps (e.g. rename file and update imports)
	if client.name == "tsserver" then
		keymap.set("n", "<leader>lo", "<cmd>TypescriptOrganizeImports<CR>", opts)
		keymap.set("n", "<leader>li", "<cmd>TypescriptAddMissingImports<CR>", opts)
		keymap.set("n", "<leader>lrf", "<cmd>TypescriptRenameFile<CR>", opts)
		keymap.set("n", "<leader>lu", "<cmd>TypescriptRemoveUnused<CR>", opts)
	end
end

-- Show line diagnostics automatically in hover window
vim.o.updatetime = 250
vim.cmd([[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]])

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
