return {
  -- dashboard
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = require("azvim.plugins.configs.alpha").opts,
    config = require("azvim.plugins.configs.alpha").setup,
  },

  -- better file browser
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
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
      "kkharji/sqlite.lua",
      { "prochri/telescope-all-recent.nvim", opts = {} },
      {
        "echasnovski/mini.fuzzy",
        config = function()
          require("mini.fuzzy").setup()
        end,
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
    opts = require("azvim.plugins.configs.which-key").opts,
    config = require("azvim.plugins.configs.which-key").setup,
  },

  -- related files (like projectionist or rails.vim)
  {
    "rgroli/other.nvim",
    event = "BufReadPost",
    config = require("azvim.plugins.configs.other").setup,
    keys = require("azvim.plugins.configs.other").keys,
  },

  -- Better `vim.notify()`
  {
    "rcarriga/nvim-notify",
    opts = {
      background_colour = "#1e222a",
      timeout = 3000,
      stages = "fade",
      max_width = function()
        return math.ceil(math.max(vim.opt.columns:get() / 3, 10))
      end,
      max_height = function()
        return math.ceil(math.max(vim.opt.lines:get() / 3, 4))
      end,
    },
    keys = {
      {
        "<leader>un",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "Dismiss all Notifications",
      },
    },
    init = function()
      vim.notify = require("notify")
    end,
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
      { "<leader>gr", "<cmd>Gread<CR>", desc = "Git Read" },
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
      "nvim-tree/nvim-web-devicons",
    },
    cmd = "Octo",
    config = function()
      require("octo").setup({
        enable_builtin = true,
      })
    end,
    keys = {
      { "<leader>gh", "<cmd>Octo<CR>", desc = "Open Octo" },
      { "<leader>gc", "<cmd>Octo pr create<CR>", desc = "Octo Create PR" },
      { "<leader>gm", "<cmd>Octo pr merge squash delete<CR>", desc = "Octo Merge PR" },
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
    lazy = true,
    init = function()
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = require("azvim.plugins.configs.noice").opts,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
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

  -- Write Obsidian notes in neovim
  {
    "epwalsh/obsidian.nvim",
    lazy = true,
    event = { "BufReadPre " .. vim.fn.expand("~") .. "/Documents/Remote Second Brain/**.md" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
      "nvim-telescope/telescope.nvim",
    },
    opts = require("azvim.plugins.configs.obsidian").opts,
    config = require("azvim.plugins.configs.obsidian").setup,
    keys = require("azvim.plugins.configs.obsidian").keys,
  },

  -- Window resizing
  {
    "anuvyklack/windows.nvim",
    dependencies = {
      "anuvyklack/middleclass",
      "anuvyklack/animation.nvim",
    },
    config = function()
      vim.o.winwidth = 10
      vim.o.winminwidth = 10
      vim.o.equalalways = false
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
}
