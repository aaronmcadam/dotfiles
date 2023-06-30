return {
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash",
          "c",
          "css",
          "fish",
          "go",
          "html",
          "java",
          "javascript",
          "json",
          "lua",
          "markdown",
          "markdown_inline",
          "hcl",
          "ruby",
          "terraform",
          "tsx",
          "typescript",
          "yaml",
        },
        highlight = {
          enable = true, -- false will disable the whole extension
        },
        indent = {
          enable = true,
        },
      })
    end,
  },

  -- commenting
  { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    opts = {
      options = {
        custom_commentstring = function()
          return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
        end,
      },
    },
  },

  -- snippets
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    config = require("azvim.plugins.configs.luasnip").setup,
    keys = require("azvim.plugins.configs.luasnip").keys,
  },

  -- copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
    },
  },

  -- completion
  {
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = "BufReadPre",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
      },
      "saadparwaiz1/cmp_luasnip",
      {
        "zbirenbaum/copilot-cmp",
        dependencies = "zbirenbaum/copilot.lua",
        config = function()
          require("copilot_cmp").setup()
        end,
      },
    },
    opts = require("azvim.plugins.configs.cmp").opts,
  },

  -- LSP
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
      { "j-hui/fidget.nvim", tag = "legacy" },
      "folke/neodev.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = require("azvim.plugins.configs.mason").setup,
  },

  -- New TypeScript LSP plugin
  -- Replaces nvim-lspconfig setup
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },

  -- diagnostics and formatting
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "jose-elias-alvarez/null-ls.nvim",
    },
    build = "npm install -g @prettier/plugin-ruby prettier-plugin-erb",
    config = require("azvim.plugins.configs.null-ls").setup,
  },

  -- better diagnostics list and others
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = { use_diagnostic_signs = true },
    keys = require("azvim.plugins.configs.trouble").keys,
  },

  -- test runners
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-go",
    },
    config = require("azvim.plugins.configs.neotest").setup,
    keys = require("azvim.plugins.configs.neotest").keys,
  },

  -- surround
  {
    "echasnovski/mini.surround",
    keys = function(_, keys)
      -- Populate the keys based on the user's options
      local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
      local opts = require("lazy.core.plugin").values(plugin, "opts", false)
      local mappings = {
        { opts.mappings.add, desc = "Add surrounding", mode = { "n", "v" } },
        { opts.mappings.delete, desc = "Delete surrounding" },
        { opts.mappings.find, desc = "Find right surrounding" },
        { opts.mappings.find_left, desc = "Find left surrounding" },
        { opts.mappings.highlight, desc = "Highlight surrounding" },
        { opts.mappings.replace, desc = "Replace surrounding" },
        { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
      }
      mappings = vim.tbl_filter(function(m)
        return m[1] and #m[1] > 0
      end, mappings)
      return vim.list_extend(mappings, keys)
    end,
    opts = {
      mappings = {
        add = "gza", -- Add surrounding in Normal and Visual modes
        delete = "gzd", -- Delete surrounding
        find = "gzf", -- Find surrounding (to the right)
        find_left = "gzF", -- Find surrounding (to the left)
        highlight = "gzh", -- Highlight surrounding
        replace = "gzr", -- Replace surrounding
        update_n_lines = "gzn", -- Update `n_lines`
      },
    },
  },
}
