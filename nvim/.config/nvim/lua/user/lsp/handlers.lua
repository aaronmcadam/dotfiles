-- Taken from https://github.com/LunarVim/nvim-basic-ide/blob/master/lua/user/lsp/handlers.lua
local M = {}

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.setup = function()
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    virtual_text = true, -- virtual text
    signs = {
      active = signs, -- show signs
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  local keymap = vim.api.nvim_buf_set_keymap
  keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  keymap(bufnr, "n", "gT", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  keymap(bufnr, "n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
  keymap(bufnr, "n", "<leader>la", "<cmd>Lspsaga code_action<CR>", opts)
  keymap(bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
  keymap(bufnr, "n", "<leader>lj", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
  keymap(bufnr, "n", "<leader>lk", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
  keymap(bufnr, "n", "<leader>lr", "<cmd>Lspsaga rename<CR>", opts)
  keymap(bufnr, "n", "<leader>ls", "<cmd>Lspsaga signature_help<CR>", opts)
  keymap(bufnr, "n", "<leader>lt", "<cmd>LSoutlineToggle<CR>", opts)
  -- Adds diagnostics to quickfix list.
  keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
  -- TypeScript
  keymap(bufnr, "n", "<leader>lo", "<cmd>TypescriptOrganizeImports<CR>", opts)
  keymap(bufnr, "n", "<leader>li", "<cmd>TypescriptAddMissingImports<CR>", opts)
  keymap(bufnr, "n", "<leader>lu", "<cmd>TypescriptRemoveUnused<CR>", opts)
end

M.on_attach = function(client, bufnr)
  local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if not status_cmp_ok then
    return
  end

  local status_navic_ok, navic = pcall(require, "nvim-navic")
  if not status_navic_ok then
    return
  end
  navic.attach(client, bufnr)

  -- Use prettier for formatting TypeScript.
  if client.name == "tsserver" then
    client.server_capabilities.document_formatting = false
  end

  if client.name == "sumneko_lua" then
    client.server_capabilities.document_formatting = false
  end

  M.capabilities.textDocument.completion.completionItem.snippetSupport = true
  M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

  lsp_keymaps(bufnr)
end

return M
