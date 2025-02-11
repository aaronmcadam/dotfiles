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
      "clangd", -- LSP for C/C++
      "cmake", -- LSP for cmake
      "gopls", -- LSP for Go
      "lua_ls", -- LSP for Lua language
      "marksman", -- LSP for Markdown
      "solargraph", -- LSP for Ruby
      "tailwindcss",
    },
  })
  mason_tool_installer.setup({
    ensure_installed = {
      "codelldb", -- Debugger for C/C++
      "codespell",
      "marksman",
      "markdownlint-cli2",
      "prettierd",
      "rubocop",
      "stylua",
    },
  })

  local capabilities = require("blink.cmp").get_lsp_capabilities()

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
    -- default handler for installed servers
    function(server_name)
      lspconfig[server_name].setup({
        capabilities = capabilities,
        on_attach = M.on_attach,
      })
    end,
    ["clangd"] = function()
      lspconfig.clangd.setup({
        capabilities = capabilities,
        on_attach = M.on_attach,
        cmd = { "clangd", "--background-index", "--clang-tidy" },
      })
    end,
    ["eslint"] = function()
      lspconfig.eslint.setup({
        capabilities = capabilities,
        on_attach = M.on_attach,
        root_dir = lspconfig.util.root_pattern(
          ".git",
          ".eslintrc*",
          "eslint.config.*",
          ".yarnrc*",
          ".npmrc*",
          ".prettierrc*"
        ),
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
  local severity = vim.diagnostic.severity
  local config = {
    virtual_text = true,
    signs = {
      text = {
        [severity.ERROR] = icons.Error,
        [severity.WARN] = icons.Warn,
        [severity.INFO] = icons.Info,
        [severity.HINT] = icons.Hint,
      },
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "single",
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
  lsp_map("gK", vim.lsp.buf.signature_help, bufnr, "Signature Help")

  -- WARN: This is not Go to Definition, this is Go to Declaration.
  --  For example, in C this would take you to the header
  lsp_map("gD", vim.lsp.buf.declaration, bufnr, "[G]o to [D]eclaration")

  -- Execute a code action, usually your cursor needs to be on top of an error
  -- or a suggestion from your LSP for this to activate.
  lsp_map("<leader>la", vim.lsp.buf.code_action, bufnr, "Code [A]ction")

  lsp_map("]d", function()
    vim.diagnostic.jump({ count = 1 })
  end, bufnr, "Go to next diagnostic")
  lsp_map("[d", function()
    vim.diagnostic.jump({ count = -1 })
  end, bufnr, "Go to previous diagnostic")

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
