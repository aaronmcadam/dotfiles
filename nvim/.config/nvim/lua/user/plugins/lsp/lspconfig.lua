local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
	return
end

local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
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

	-- set keybinds
	keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts) -- show definition, references
	keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
  keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  keymap.set("n", "gT", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
  keymap.set("n", "<leader>la", "<cmd>Lspsaga code_action<CR>", opts)
  keymap.set("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
  keymap.set("n", "<leader>lj", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
  keymap.set("n", "<leader>lk", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
  keymap.set("n", "<leader>lr", "<cmd>Lspsaga rename<CR>", opts)
  keymap.set("n", "<leader>lrs", "<cmd>LspRestart<CR>", opts)
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

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Change the Diagnostic symbols in the sign column (gutter)
local signs = { Error = " ", Warn = " ", Hint = "ﴞ ", Info = " " }

for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type

	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- configure typescript server with plugin
typescript.setup({
	server = {
		capabilities = capabilities,
		on_attach = on_attach,
	},
})

-- configure lua server (with special settings)
lspconfig["sumneko_lua"].setup({
	capabilities = capabilities,
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
