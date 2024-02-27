local M = {}

function M.setup()
  -- Set up Mason before anything else
  local mason = require("mason")
  local mason_lspconfig = require("mason-lspconfig")
  local mason_tool_installer = require("mason-tool-installer")
  local lspconfig = require("lspconfig")

  mason.setup({
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
    },
  })
  mason_lspconfig.setup({
    ensure_installed = {
      "lua_ls", -- LSP for Lua language
      "gopls", -- LSP for Go
      "clangd", -- LSP for C/C++
      "solargraph", -- LSP for Ruby
      "tailwindcss",
      "eslint", -- LSP for ESLint code actions
    },
  })
  mason_tool_installer.setup({
    ensure_installed = {
      "codelldb", -- Debugger for C/C++
      "codespell",
      "eslint_d",
      "prettierd",
      "rubocop",
      "stylua",
    },
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

  -- Setup every needed language server in lspconfig
  mason_lspconfig.setup_handlers({
    function(server_name)
      lspconfig[server_name].setup({
        capabilities = capabilities,
        on_attach = M.on_attach,
      })
    end,
    ["lua_ls"] = function()
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        on_attach = M.on_attach,
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
    end,
    ["clangd"] = function()
      lspconfig.clangd.setup({
        capabilities = capabilities,
        on_attach = M.on_attach,
        cmd = { "clangd", "--background-index", "--clang-tidy" },
      })
    end,
    ["cmake"] = function()
      lspconfig.cmake.setup({
        capabilities = capabilities,
        on_attach = M.on_attach,
      })
    end,
    ["solargraph"] = function()
      lspconfig.solargraph.setup({
        capabilities = capabilities,
        on_attach = M.on_attach,
        settings = {
          solargraph = {
            diagnostics = false,
          },
        },
      })
    end,
  })

  -- Neodev setup before LSP config
  require("neodev").setup()

  -- Turn on LSP status information
  require("fidget").setup({
    window = {
      blend = 0,
    },
  })

  -- Set up cool signs for diagnostics
  local icons = require("azvim.core.helpers").icons.diagnostics
  local signs = {
    Error = icons.Error,
    Warn = icons.Warn,
    Hint = icons.Hint,
    Info = icons.Info,
  }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
  end

  -- Diagnostic config
  local config = {
    virtual_text = true,
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
end

function M.on_attach(client, bufnr)
  local navic = require("nvim-navic")
  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end

  local lsp_map = require("azvim.helpers.keys").lsp_map

  lsp_map("gd", require("telescope.builtin").lsp_definitions, bufnr, "[G]o to [D]efinition")
  lsp_map("gI", require("telescope.builtin").lsp_implementations, bufnr, "[G]o to [I]mplementation")
  lsp_map("gr", require("telescope.builtin").lsp_references, bufnr, "[G]o to [R]eferences")
  -- Jump to the type of the word under your cursor.
  --  Useful when you're not sure what type a variable is and you want to see
  --  the definition of its *type*, not where it was *defined*.
  lsp_map("gt", require("telescope.builtin").lsp_type_definitions, bufnr, "[G]o to [T]ype")

  -- Opens a popup that displays documentation about the word under your cursor
  --  See `:help K` for why this keymap
  lsp_map("K", vim.lsp.buf.hover, bufnr, "Hover Documentation")

  -- WARN: This is not Go to Definition, this is Go to Declaration.
  --  For example, in C this would take you to the header
  lsp_map("gD", vim.lsp.buf.declaration, bufnr, "[G]o to [D]eclaration")

  -- Execute a code action, usually your cursor needs to be on top of an error
  -- or a suggestion from your LSP for this to activate.
  lsp_map("<leader>la", vim.lsp.buf.code_action, bufnr, "Code [A]ction")

  lsp_map("<leader>lj", vim.diagnostic.goto_next, bufnr, "Go to next diagnostic ('j' for down)")
  lsp_map("<leader>lk", vim.diagnostic.goto_prev, bufnr, "Go to previous diagnostic ('k' for up)")

  -- Rename the variable under your cursor
  --  Most Language Servers support renaming across files, etc.
  lsp_map("<leader>lr", vim.lsp.buf.rename, bufnr, "[R]ename symbol")

  -- Fuzzy find all the symbols in your current document
  --  Symbols are things like variables, functions, types, etc.
  lsp_map("<leader>ls", require("telescope.builtin").lsp_document_symbols, bufnr, "Document [S]ymbols")

  -- Fuzzy find all the symbols in your current workspace
  --  Similar to document symbols, except searches over your whole project.
  lsp_map("<leader>lw", require("telescope.builtin").lsp_dynamic_workspace_symbols, bufnr, "[W]orkspace Symbols")

  -- TypeScript specific keymaps
  -- stylua: ignore
  if client.name == "typescript-tools" then
    lsp_map("<leader>ld", function() vim.cmd("TSToolsGoToSourceDefinition") end, bufnr, "Go to source definition")
    lsp_map("<leader>lf", function() vim.cmd("TSToolsRenameFile") end, bufnr, "Rename file")
    lsp_map("<leader>li", function() vim.cmd("TSToolsAddMissingImports") end, bufnr, "Add missing imports")
    lsp_map("<leader>lo", function() vim.cmd("TSToolsOrganizeImports") end, bufnr, "Organize imports")
    lsp_map("<leader>lu", function() vim.cmd("TSToolsRemoveUnused") end, bufnr, "Remove unused statements")
  end

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, "Format", function()
    vim.lsp.buf.format()
  end, { desc = "Format current buffer with LSP" })
end

return M
