local M = {}

function M.setup()
  local lsps = {
    "clangd", -- LSP for C/C++
    "cmake", -- LSP for cmake
    "copilot",
    "eslint",
    "harper_ls", -- Grammar checker
    "gopls", -- LSP for Go
    "lua_ls", -- LSP for Lua
    "marksman", -- LSP for Markdown
    "solargraph", -- LSP for Ruby
    "tailwindcss",
  }

  M.before_setup()
  M.setup_diagnostics()
  M.setup_lsps(lsps)
  M.setup_mason(lsps)
end

function M.before_setup()
  -- Neodev setup before LSP config
  require("neodev").setup()

  -- Turn on LSP status information
  require("fidget").setup({
    window = {
      blend = 0,
    },
  })
end

function M.on_attach(client, bufnr)
  local navic = require("nvim-navic")
  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end

  local lsp_map = require("azvim.helpers.keys").lsp_map

  -- Opens a popup that displays documentation about the word under your cursor
  --  See `:help K` for why this keymap
  lsp_map("K", vim.lsp.buf.hover, bufnr, "Hover Documentation")
  lsp_map("gK", vim.lsp.buf.signature_help, bufnr, "Signature Help")

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

function M.setup_diagnostics()
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

function M.setup_lsps(lsps)
  vim.lsp.enable(lsps)

  local capabilities = M.create_capabilities()

  vim.lsp.config("clangd", {
    capabilities = capabilities,
    on_attach = M.on_attach,
    cmd = { "clangd", "--background-index", "--clang-tidy" },
  })

  vim.lsp.config("cmake", {
    capabilities = capabilities,
    on_attach = M.on_attach,
  })

  -- Custom root_dir to work around nvim-lspconfig eslint bug
  -- See: https://github.com/neovim/nvim-lspconfig/pull/4022
  vim.lsp.config("eslint", {
    capabilities = capabilities,
    on_attach = M.on_attach,
    root_dir = function(fname)
      return vim.fs.root(fname, {
        "package-lock.json",
        "yarn.lock",
        "pnpm-lock.yaml",
        "bun.lockb",
        "bun.lock",
        ".git",
        ".eslintrc",
        ".eslintrc.js",
        ".eslintrc.json",
        "eslint.config.js",
        "eslint.config.mjs",
        "package.json",
      })
    end,
  })

  vim.lsp.config("gopls", {
    capabilities = capabilities,
    on_attach = M.on_attach,
  })

  vim.lsp.config("harper_ls", {
    capabilities = capabilities,
    on_attach = M.on_attach,
    filetypes = { "markdown" },
    settings = {
      ["harper-ls"] = {
        dialect = "British",
        linters = {
          ToDoHyphen = false,
        },
        markdown = {
          -- [ignores this part]()
          -- [[also ignores Obsidian links]]
          IgnoreLinkTitle = true,
        },
        userDictPath = vim.fn.expand("~/.config/nvim/spell/en.utf-8.add"),
      },
    },
  })

  vim.lsp.config("lua_ls", {
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

  vim.lsp.config("marksman", {
    capabilities = capabilities,
    on_attach = M.on_attach,
  })

  vim.lsp.config("solargraph", {
    capabilities = capabilities,
    on_attach = M.on_attach,
    settings = {
      solargraph = {
        diagnostics = false,
      },
    },
  })

  vim.lsp.config("tailwindcss", {
    capabilities = capabilities,
    on_attach = M.on_attach,
  })
end

function M.setup_mason(lsps)
  local mason = require("mason")
  local mason_lspconfig = require("mason-lspconfig")
  local mason_tool_installer = require("mason-tool-installer")

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
    automatic_enable = false,
    ensure_installed = lsps,
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
end

function M.create_capabilities()
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

  return capabilities
end

return M
