return {
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = require("azvim.plugins.configs.treesitter").setup,
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
    opts = require("azvim.plugins.configs.mini-surround").opts,
    keys = require("azvim.plugins.configs.mini-surround").keys,
  },
}
