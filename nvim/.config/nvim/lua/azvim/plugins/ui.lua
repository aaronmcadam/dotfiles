return {
  -- icons
  {
    "echasnovski/mini.icons",
    lazy = true,
    opts = {
      filetype = {
        dotenv = { glyph = "", hl = "MiniIconsYellow" },
      },
    },
    init = function()
      require("mini.icons").mock_nvim_web_devicons()
    end,
  },

  -- dashboard
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "echasnovski/mini.icons" },
    opts = require("azvim.plugins.configs.alpha").opts,
    config = require("azvim.plugins.configs.alpha").setup,
  },

  -- better file browser
  {
    "stevearc/oil.nvim",
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    opts = {
      -- Set to false if you want some other plugin (e.g. netrw) to open when you edit directories.
      default_file_explorer = true,
      view_options = {
        show_hidden = true,
      },
    },
    keys = {
      {
        "-",
        "<cmd>lua require('oil').open()<CR>",
        desc = "Open parent directory",
      },
    },
  },

  -- Better statusline and winbar
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "SmiteshP/nvim-navic",
      "echasnovski/mini.icons",
      "meuter/lualine-so-fancy.nvim",
    },
    event = "VeryLazy",
    opts = require("azvim.plugins.configs.lualine").opts,
  },
  {
    "SmiteshP/nvim-navic",
    opts = function()
      return {
        separator = " ",
        highlight = true,
        depth_limit = 5,
        icons = require("azvim.core.helpers").icons.kinds,
      }
    end,
  },

  -- harpoon
  {
    "ThePrimeagen/harpoon",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = require("azvim.plugins.configs.harpoon").keys,
    config = require("azvim.plugins.configs.harpoon").setup,
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "ThePrimeagen/harpoon",
      "debugloop/telescope-undo.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      {
        "danielfalk/smart-open.nvim",
        branch = "0.2.x",
        dependencies = {
          "kkharji/sqlite.lua",
          { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
      },
    },
    cmd = "Telescope",
    keys = require("azvim.plugins.configs.telescope").keys,
    config = require("azvim.plugins.configs.telescope").setup,
  },

  -- which key
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = { spelling = true },
    },
    config = require("azvim.plugins.configs.which-key").setup,
  },

  -- related files
  {
    "tpope/vim-projectionist",
    lazy = false,
    config = function()
      -- Borrowed ideas from:
      -- https://github.com/akinsho/dotfiles/blob/d81e2f0cd00d71170107ed30db34fc644173a411/.config/nvim/lua/as/plugins/projects.lua#L2
      vim.g.projectionist_heuristics = {
        ["*"] = {
          ["*.ts"] = {
            alternate = "{}.test.ts",
            type = "source",
          },
          ["*.tsx"] = {
            alternate = { "{}.test.tsx", "{}.stories.tsx", "{}.stories.ts" },
            type = "component",
          },
          ["*.test.ts"] = {
            alternate = "{}.ts",
            type = "test",
          },
          ["*.test.tsx"] = {
            alternate = "{}.tsx",
            type = "test",
            template = {
              "import {basename|camelcase|capitalize} from '.';",
              "",
              "describe('{basename|camelcase|capitalize}', () => {open}",
              "  test('renders successfully', () => {open}",
              "    render(<{basename|camelcase|capitalize} />, {open}{close});",
              "    expect(true).toBe(true);",
              "   {close});",
              "{close});",
            },
          },
          ["*.stories.ts"] = {
            alternate = { "{}.tsx", "{}.test.tsx" },
            type = "story",
          },
          ["*.stories.tsx"] = {
            alternate = { "{}.tsx", "{}.test.tsx" },
            type = "story",
          },
        },
      }
    end,
    keys = {
      { "<leader>kk", "<cmd>A<CR>", desc = "Open related file" },
      { "<leader>kv", "<cmd>AV<CR>", desc = "Open related file in split" },
      { "<leader>kt", "<cmd>Vtest<CR>", desc = "Open test" },
      { "<leader>ks", "<cmd>Vstory<CR>", desc = "Open story" },
    },
  },

  -- Git
  {
    "tpope/vim-fugitive",
    cmd = {
      "Git",
      "GBrowse",
      "Gread",
      "Gwrite",
      "Gdiffsplit",
      "Gvdiffsplit",
    },
    keys = {
      { "<leader>gv", "<cmd>GBrowse<CR>", desc = "Git View in Browser" },
      -- { "<leader>gd", "<cmd>Gvdiffsplit<CR>", desc = "Git Diff" },
      { "<leader>gr", "<cmd>Gread<CR><cmd>update<CR>", desc = "Git Read" },
      { "<leader>gw", "<cmd>Gwrite<CR>", desc = "Git Write" },
    },
  },
  {
    "ruifm/gitlinker.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    opts = {
      -- default mapping to call url generation with action_callback
      mappings = "<leader>gy",
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    opts = function()
      local C = {
        on_attach = function(buffer)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, desc)
            vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
          end

          map("n", "]g", gs.next_hunk, "Next Hunk")
          map("n", "[g", gs.prev_hunk, "Prev Hunk")
          map("n", "<leader>gb", function()
            gs.blame_line({ full = true })
          end, "Blame Line")
        end,
      }

      return C
    end,
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "nvim-telescope/telescope.nvim", -- optional
      "sindrets/diffview.nvim", -- optional
    },
    keys = {
      { "<leader>gg", "<cmd>Neogit<CR>", desc = "Git" },
      { "<leader>gdd", "<cmd>DiffviewOpen<CR>", desc = "Git Diff Open" },
      { "<leader>gdc", "<cmd>DiffviewClose<CR>", desc = "Git Diff Close" },
      { "<leader>gdh", "<cmd>DiffviewFileHistory %<CR>", desc = "Git Diff Current File History" },
      { "<leader>gda", "<cmd>DiffviewFileHistory<CR>", desc = "Git Diff All File History" },
      { "<leader>gp", "<cmd>Neogit push<CR>", desc = "Git Push" },
    },
    config = function()
      require("neogit").setup()
    end,
  },
  -- Manage GitHub issues and PRs
  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "echasnovski/mini.icons",
    },
    cmd = "Octo",
    config = function()
      require("octo").setup({
        enable_builtin = true,
      })
    end,
    keys = {
      { "<leader>gh", "<cmd>Octo<CR>", desc = "Open Octo" },
      { "<leader>oo", "<cmd>Octo pr list<CR>", desc = "Octo PR list all" },
      { "<leader>oc", "<cmd>Octo pr create<CR>", desc = "Octo PR create" },
      { "<leader>om", "<cmd>Octo pr merge squash delete<CR>", desc = "Octo PR merge" },
      { "<leader>ov", "<cmd>Octo pr browser<CR>", desc = "Octo PR open in browser" },
      { "<leader>oh", "<cmd>Octo pr checkout<CR>", desc = "Octo PR checkout" },
      { "<leader>ox", "<cmd>Octo pr create draft<CR>", desc = "Octo PR create draft" },
      { "<leader>od", "<cmd>Octo pr diff<CR>", desc = "Octo PR diff" },
      { "<leader>oy", "<cmd>Octo pr url<CR>", desc = "Octo PR copy URL" },
      { "<leader>of", "<cmd>Octo pr changes<CR>", desc = "Octo PR list changed files" },
      { "<leader>oj", "<cmd>Octo pr checks<CR>", desc = "Octo PR checks" },
      { "<leader>ol", "<cmd>Octo pr commits<CR>", desc = "Octo PR list commits" },
      { "<leader>or", "<cmd>Octo pr reload<CR>", desc = "Octo PR reload" },
    },
  },

  -- indent guides for Neovim
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = require("azvim.plugins.configs.indent-blankline").opts,
  },

  -- Nicer UI
  {
    "stevearc/dressing.nvim",
    opts = {},
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = require("azvim.plugins.configs.noice").opts,
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
  },

  -- todo comments
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPost", "BufNewFile" },
    config = true,
    opts = require("azvim.plugins.configs.todo-comments").opts,
    keys = require("azvim.plugins.configs.todo-comments").keys,
  },

  -- search/replace in multiple files
  {
    "nvim-pack/nvim-spectre",
    cmd = "Spectre",
    opts = {
      open_cmd = "noswapfile vnew",
    },
    keys = {
      {
        "<leader>fr",
        function()
          require("spectre").open()
        end,
        desc = "Replace in files (Spectre)",
      },
    },
  },

  -- Window resizing
  {
    "anuvyklack/windows.nvim",
    dependencies = {
      "anuvyklack/middleclass",
    },
    config = function()
      require("windows").setup()
    end,
    keys = {
      {
        "<leader>zz",
        "<cmd>WindowsMaximize<CR>",
        desc = "Maximize Window",
      },
      {
        "<leader>zv",
        "<cmd>WindowsMaximizeVertically<CR>",
        desc = "Maximize Window Vertically",
      },
      {
        "<leader>zh",
        "<cmd>WindowsMaximizeHorizontally<CR>",
        desc = "Maximize Window Horizontally",
      },
      {
        "<leader>ze",
        "<cmd>WindowsEqualize<CR>",
        desc = "Equalize all Windows",
      },
      {
        "<leader>zt",
        "<cmd>WindowsToggleAutowidth<CR>",
        desc = "Toggle Windows Auto-width",
      },
    },
  },

  -- better quickfix
  {
    "kevinhwang91/nvim-bqf",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "VeryLazy",
    opts = {},
  },

  -- Write Obsidian notes in neovim
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = require("azvim.plugins.configs.obsidian").opts,
    keys = require("azvim.plugins.configs.obsidian").keys,
  },

  -- better markdown formatting
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {},
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
  },

  -- for writing prose
  {
    "preservim/vim-pencil",
  },

  -- ChatGPT
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    opts = require("azvim.plugins.configs.chatgpt").opts,
    keys = require("azvim.plugins.configs.chatgpt").keys,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },

  -- Build better Neovim habits
  -- lazy.nvim
  {
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    opts = {},
  },
  {
    "tris203/precognition.nvim",
    opts = {},
  },
}
