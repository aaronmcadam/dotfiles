local M = {}

M.setup = function()
  -- Set up Mason before anything else
  require("mason").setup()
  require("mason-lspconfig").setup({
    ensure_installed = {
      "gopls",
      "lua_ls",
      "solargraph",
    },
    automatic_installation = true,
  })

  -- Quick access via keymap
  require("azvim.helpers.keys").map("n", "<leader>M", "<cmd>Mason<cr>", "Show Mason")

  -- Neodev setup before LSP config
  require("neodev").setup()

  -- Turn on LSP status information
  require("fidget").setup()

  -- Set up cool signs for diagnostics
  local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
  end

  -- Diagnostic config
  local config = {
    virtual_text = false,
    signs = {
      active = signs,
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

  -- Global mappings.
  vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
  vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

  -- Use LspAttach autocommand to only map the following keys
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("AzVimLspConfig", {}),
    callback = function(ev)
      -- Enable completion triggered by <c-x><c-o>
      -- vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

      local opts = { buffer = ev.buf }
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
      vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
      vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
      vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
      vim.keymap.set("n", "<space>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, opts)
      vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
      vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
      vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
      vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
      vim.keymap.set("n", "<space>f", function()
        vim.lsp.buf.format({ async = true })
      end, opts)
    end,
  })

  -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
  capabilities.textDocument.completion.completionItem = {
    documentationFormat = { "markdown", "plaintext" },
    snippetSupport = true,
    preselectSupport = true,
    insertReplaceSupport = true,
    labelDetailsSupport = true,
    deprecatedSupport = true,
    commitCharactersSupport = true,
    tagSupport = { valueSet = { 1 } },
    resolveSupport = {
      properties = {
        "documentation",
        "detail",
        "additionalTextEdits",
      },
    },
  }
  -- Setup language servers.
  local lspconfig = require("lspconfig")

  -- golang
  lspconfig.gopls.setup({
    capabilities = capabilities,
    settings = {
      gopls = {
        completeUnimported = true,
        usePlaceholders = true,
      },
    },
  })

  -- lua
  lspconfig.lua_ls.setup({
    capabilities = capabilities,
    settings = {
      Lua = {
        completion = {
          callSnippet = "Replace",
        },
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.stdpath("config") .. "/lua"] = true,
          },
        },
      },
    },
  })

  -- Some language servers don't need special options,
  -- so we can set them all up in a loop.
  local servers = { "html", "cssls" }

  for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup({
      capabilities = capabilities,
    })
  end
end

return M
