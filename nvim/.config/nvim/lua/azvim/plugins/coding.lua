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
    event = "InsertEnter",
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
      "SmiteshP/nvim-navic",
    },
    config = require("azvim.plugins.configs.lsp").setup,
  },

  -- New TypeScript LSP plugin
  -- Replaces nvim-lspconfig setup
  {
    "pmizio/typescript-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      on_attach = require("azvim.plugins.configs.lsp").on_attach,
    },
  },

  -- diagnostics and formatting
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "jose-elias-alvarez/null-ls.nvim",
    },
    -- build = "npm install -g @prettier/plugin-ruby prettier-plugin-erb",
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
      "marilari88/neotest-vitest",
      "olimorris/neotest-rspec",
    },
    config = require("azvim.plugins.configs.neotest").setup,
    keys = require("azvim.plugins.configs.neotest").keys,
  },

  -- debugging
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- fancy UI for the debugger
      {
        "rcarriga/nvim-dap-ui",
        config = require("azvim.plugins.configs.dap").setup_ui,
        opts = {},
        keys = require("azvim.plugins.configs.dap").ui_keys,
      },

      -- virtual text for the debugger
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
      },

      -- mason.nvim integration
      {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = "mason.nvim",
        cmd = { "DapInstall", "DapUninstall" },
        opts = {
          ensure_installed = {
            "delve", -- Go debugger
          },
          automatic_installation = true,
          handlers = {},
        },
      },
    },
    config = require("azvim.plugins.configs.dap").setup,
    keys = require("azvim.plugins.configs.dap").keys,
  },

  -- surround
  {
    "echasnovski/mini.surround",
    opts = require("azvim.plugins.configs.mini-surround").opts,
    keys = require("azvim.plugins.configs.mini-surround").keys,
  },

  -- better matchit
  {
    "andymass/vim-matchup",
    opts = {},
  },

  -- LeetCode
  {
    "Dhanus3133/LeetBuddy.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("leetbuddy").setup({
        language = "ts",
      })
    end,
    keys = {
      { "<leader>cq", "<cmd>LBQuestions<cr>", desc = "List Questions" },
      { "<leader>cl", "<cmd>LBQuestion<cr>", desc = "View Question" },
      { "<leader>cr", "<cmd>LBReset<cr>", desc = "Reset Code" },
      { "<leader>ct", "<cmd>LBTest<cr>", desc = "Run Code" },
      { "<leader>cs", "<cmd>LBSubmit<cr>", desc = "Submit Code" },
    },
  },

  -- better undo
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    keys = {
      { "<leader>uu", vim.cmd.UndotreeToggle, desc = "Open Undotree" },
      { "<leader>uf", vim.cmd.UndotreeFocus, desc = "Focus Undotree" },
    },
  },

  -- better motions
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = require("azvim.plugins.configs.flash").keys,
  },

  -- refactoring
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("refactoring").setup()
    end,
  },
}
