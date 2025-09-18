return {
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = require("azvim.plugins.configs.treesitter").setup,
  },

  -- text objects
  {
    "nvim-mini/mini.ai",
    dependencies = {
      "nvim-mini/mini.extra",
    },
    opts = require("azvim.plugins.configs.mini-ai").opts,
  },

  -- commenting
  { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
  {
    "nvim-mini/mini.comment",
    event = "VeryLazy",
    opts = {
      options = {
        custom_commentstring = function()
          return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
        end,
      },
    },
  },

  -- completion
  {
    "saghen/blink.cmp",
    version = "*",
    opts = require("azvim.plugins.configs.blink").opts,
  },

  -- LSP
  {
    "mason-org/mason.nvim",
    build = ":MasonUpdate",
    dependencies = {
      "mason-org/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "saghen/blink.cmp",
      { "j-hui/fidget.nvim", tag = "legacy" },
      "folke/neodev.nvim",
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
      settings = {
        tsserver_file_preferences = {
          autoImportFileExcludePatterns = {
            "@radix-ui/*",
            "node:test",
          },
        },
      },
    },
  },
  { "dmmulroy/ts-error-translator.nvim", config = true },

  -- formatting
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = require("azvim.plugins.configs.conform").opts,
  },

  -- linting
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = require("azvim.plugins.configs.lint").setup,
  },

  -- package.json info
  {
    "vuki656/package-info.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    config = require("azvim.plugins.configs.package-info").setup,
    keys = require("azvim.plugins.configs.package-info").keys,
  },

  -- color design tokens
  {
    "NvChad/nvim-colorizer.lua",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      user_default_options = {
        tailwind = true,
      },
    },
  },

  -- better diagnostics list
  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    opts = {},
    keys = require("azvim.plugins.configs.trouble").keys,
  },

  -- test runners
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-go",
      "marilari88/neotest-vitest",
      "olimorris/neotest-rspec",
    },
    config = require("azvim.plugins.configs.neotest").setup,
    keys = require("azvim.plugins.configs.neotest").keys,
  },

  -- debugging
  -- {
  --   "mfussenegger/nvim-dap",
  --   dependencies = {
  --     -- fancy UI for the debugger
  --     {
  --       "rcarriga/nvim-dap-ui",
  --       config = require("azvim.plugins.configs.dap").setup_ui,
  --       opts = {},
  --       keys = require("azvim.plugins.configs.dap").ui_keys,
  --     },
  --
  --     -- virtual text for the debugger
  --     {
  --       "theHamsta/nvim-dap-virtual-text",
  --       opts = {},
  --     },
  --
  --     -- mason.nvim integration
  --     {
  --       "jay-babu/mason-nvim-dap.nvim",
  --       dependencies = "mason.nvim",
  --       cmd = { "DapInstall", "DapUninstall" },
  --       opts = {
  --         ensure_installed = {
  --           "delve", -- Go debugger
  --         },
  --         automatic_installation = true,
  --         handlers = {},
  --       },
  --     },
  --   },
  --   config = require("azvim.plugins.configs.dap").setup,
  --   keys = require("azvim.plugins.configs.dap").keys,
  -- },

  -- surround
  {
    "nvim-mini/mini.surround",
    opts = require("azvim.plugins.configs.mini-surround").opts,
    keys = require("azvim.plugins.configs.mini-surround").keys,
  },

  -- better matchit
  {
    "andymass/vim-matchup",
    opts = {},
  },

  -- better undo
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    keys = {
      { "<leader>uu", vim.cmd.UndotreeToggle, desc = "Toggle Undotree" },
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
    lazy = false,
    config = function()
      require("refactoring").setup()
    end,
  },

  -- split/join
  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = { "TSJToggle", "TSJJoin", "TSJSplit" },
    keys = {
      {
        "<leader>j",
        "<cmd>TSJToggle<cr>",
        desc = "Toggle Split/Join",
      },
    },
    opts = { use_default_keymaps = false },
  },

  -- c lang
  {
    "Zeioth/compiler.nvim",
    cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
    dependencies = { "stevearc/overseer.nvim" },
    opts = {},
    keys = {
      { "<leader>lc", "<cmd>CompilerOpen<cr>", desc = "Toggle Compiler" },
    },
  },
  {
    "stevearc/overseer.nvim",
    cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
    opts = {
      task_list = {
        direction = "bottom",
        min_height = 25,
        max_height = 25,
        default_detail = 1,
      },
    },
  },
}
