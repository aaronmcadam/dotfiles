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
    keys = {
      { "<leader>gcc", "<cmd>CopilotEnable<cr>", desc = "Enable Copilot" },
      { "<leader>gcd", "<cmd>CopilotDisable<cr>", desc = "Disable Copilot" },
    },
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })

      -- Disable Copilot on startup
      vim.cmd("Copilot disable")

      -- Create commands to manually enable and disable Copilot
      vim.api.nvim_create_user_command("CopilotEnable", function()
        vim.cmd("Copilot enable")
        vim.notify("Copilot Enabled", vim.log.levels.INFO)
      end, { desc = "Enable Copilot" })

      vim.api.nvim_create_user_command("CopilotDisable", function()
        vim.cmd("Copilot disable")
        vim.notify("Copilot Disabled", vim.log.levels.INFO)
      end, { desc = "Disable Copilot" })
    end,
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
      {
        "petertriho/cmp-git",
        dependencies = "nvim-lua/plenary.nvim",
        config = function()
          require("cmp_git").setup()
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
      "WhoIsSethDaniel/mason-tool-installer.nvim",
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
  { "dmmulroy/ts-error-translator.nvim", config = true },

  -- formatting
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = function()
      local prettier = { "prettierd", "prettier", stop_after_first = true }

      return {
        formatters_by_ft = {
          html = prettier,
          javascript = prettier,
          javascriptreact = prettier,
          json = prettier,
          lua = { "stylua" },
          markdown = prettier,
          typescript = prettier,
          typescriptreact = prettier,
          yaml = prettier,
          -- Use the "_" filetype to run formatters on filetypes that don't
          -- have other formatters configured.
          ["_"] = { "trim_whitespace" },
        },
        format_on_save = {
          -- It's safer for now to turn off async formatting
          -- because it could lead to strange behavior such as
          -- updating the buffer text in unpredictable ways.
          async = false,
          lsp_fallback = true,
          timeout_ms = 1000,
        },
      }
    end,
  },

  -- linting
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        markdown = { "markdownlint-cli2" },
      }

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })
    end,
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

  -- package.json info
  {
    "vuki656/package-info.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    config = function()
      local colors = require("catppuccin.palettes").get_palette("mocha")

      require("package-info").setup({
        -- autostart = false,
        package_manager = "pnpm",
        colors = {
          outdated = colors.peach,
        },
        hide_up_to_date = true,
      })
    end,
    keys = {
      { "<leader>lpt", "<cmd>lua require('package-info').toggle()<cr>", desc = "Toggle" },
      { "<leader>lpd", "<cmd>lua require('package-info').delete()<cr>", desc = "Delete package" },
      { "<leader>lpu", "<cmd>lua require('package-info').update()<cr>", desc = "Update package" },
      { "<leader>lpi", "<cmd>lua require('package-info').install()<cr>", desc = "Install package" },
      { "<leader>lpc", "<cmd>lua require('package-info').change_version()<cr>", desc = "Change package version" },
    },
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
