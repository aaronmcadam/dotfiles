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
    "echasnovski/mini.ai",
    dependencies = {
      "echasnovski/mini.extra",
    },
    opts = function()
      local gen_bundled_spec = require("mini.ai").gen_spec
      local gen_extra_spec = require("mini.extra").gen_ai_spec
      return {
        n_lines = 500,
        custom_textobjects = {
          c = gen_bundled_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class
          d = gen_extra_spec.number(), -- digits
          f = gen_bundled_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
          g = gen_extra_spec.buffer(), -- buffer. g similar to G/gg motion
          i = gen_extra_spec.indent(),
          o = gen_bundled_spec.treesitter({ -- code block. o for "Outer"
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }),
          r = gen_extra_spec.line(), -- r for "Row"
          u = gen_bundled_spec.function_call(), -- u for "Usage"
          U = gen_bundled_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
          x = gen_extra_spec.diagnostic(), -- diagnostic
        },
      }
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
        suggestion = { enabled = true },
        panel = { enabled = false },
      })

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
    "saghen/blink.cmp",
    version = "*",
    dependencies = {
      { "saghen/blink.compat", lazy = true },
    },
    opts = {
      keymap = {
        preset = "default",
        -- These are the default Neovim completion keybindings:
        -- <C-n> - Select next item
        -- <C-p> - Select previous item
        -- <C-y> - Accept ([y]es) the completion
        -- <C-Space> - Manually trigger a completion
        -- <C-e> - Abort the completion (hides the menu)

        -- These are custom keybindings:
        -- Think of <C-l> as moving to the right of your snippet expansion.
        --  So if you have a snippet that's like:
        --  function $name($args)
        --    $body
        --  end
        --
        -- <C-l> will move you to the right of each of the expansion locations.
        -- <C-h> is similar, except moving you backwards.
        ["<C-l>"] = { "snippet_forward", "fallback" },
        ["<C-h>"] = { "snippet_backward", "fallback" },
      },
      completion = {
        menu = {
          border = "single",
          draw = {
            treesitter = { "lsp" },
          },
        },
        -- Show documentation when selecting a completion item
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
          window = {
            border = "single",
          },
        },
      },
      sources = {
        default = {
          "obsidian",
          "obsidian_new",
          "obsidian_tags",
          "snippets",
          "lsp",
          "buffer",
          "path",
          "avante_commands",
          "avante_mentions",
          "avante_files",
        },
        -- Disable cmdline completions
        providers = {
          obsidian = {
            name = "obsidian",
            module = "blink.compat.source",
          },
          obsidian_new = {
            name = "obsidian_new",
            module = "blink.compat.source",
          },
          obsidian_tags = {
            name = "obsidian_tags",
            module = "blink.compat.source",
          },
          avante_commands = {
            name = "avante_commands",
            module = "blink.compat.source",
            score_offset = 90, -- show at a higher priority than lsp
            opts = {},
          },
          avante_files = {
            name = "avante_files",
            module = "blink.compat.source",
            score_offset = 100, -- show at a higher priority than lsp
            opts = {},
          },
          avante_mentions = {
            name = "avante_mentions",
            module = "blink.compat.source",
            score_offset = 1000, -- show at a higher priority than lsp
            opts = {},
          },
          lsp = {
            enabled = function()
              -- We want to use the obsidian completion source for markdown
              -- to avoid entries for both marksman and obsidian.
              return vim.bo.filetype ~= "markdown"
            end,
          },
          buffer = {
            enabled = function()
              -- We want to avoid words from the buffer completions in markdown
              -- so the note link completions are prioritised within Obisidian notes.
              return vim.bo.filetype ~= "markdown"
            end,
          },
        },
      },
      cmdline = {
        enabled = false,
      },
    },
  },

  -- LSP
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "neovim/nvim-lspconfig",
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
    opts = function()
      local prettier = { "prettierd", "prettier", stop_after_first = true }

      return {
        formatters_by_ft = {
          html = prettier,
          javascript = prettier,
          javascriptreact = prettier,
          json = prettier,
          lua = { "stylua" },
          -- markdown = { "markdownlint-cli2" },
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
        javascript = { "eslint" },
        typescript = { "eslint" },
        javascriptreact = { "eslint" },
        typescriptreact = { "eslint" },
        markdown = { "markdownlint-cli2" },
      }

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          -- Avoid error messages, such as: "Error running eslint: ENOENT: no such file or directory"
          -- @see https://github.com/mfussenegger/nvim-lint/issues/454
          lint.try_lint(nil, { ignore_errors = true })
        end,
      })
    end,
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
