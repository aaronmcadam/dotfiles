local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  return
end

local servers = {
  "jsonls",
  "sumneko_lua",
  "tflint",
  "tsserver",
  "yamlls",
}

lsp_installer.setup()

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local opts = {}

for _, server in pairs(servers) do
  opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
  }

  -- add a special case for tsserver, since we want to go through typescript.nvim here
  if server == "tsserver" then
    require("typescript").setup({ server = opts })
  else
    if server == "jsonls" then
      local jsonls_opts = require "user.lsp.settings.jsonls"
      opts = vim.tbl_deep_extend("force", jsonls_opts, opts)

    end

    if server == "sumneko_lua" then
      local sumneko_opts = require "user.lsp.settings.sumneko_lua"
      opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
    end

    lspconfig[server].setup(opts)
  end
end
