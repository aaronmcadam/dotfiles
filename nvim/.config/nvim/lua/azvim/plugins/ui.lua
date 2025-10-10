return {
  -- icons
  {
    "nvim-mini/mini.icons",
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

  -- better file browser
  {
    "stevearc/oil.nvim",
    dependencies = { { "nvim-mini/mini.icons", opts = {} } },
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
      "nvim-mini/mini.icons",
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
    branch = "harpoon2",
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
      "debugloop/telescope-undo.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
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
      preset = "helix",
      plugins = { spelling = true },
    },
    config = require("azvim.plugins.configs.which-key").setup,
  },

  -- related files
  {
    "tpope/vim-projectionist",
    lazy = false,
    config = require("azvim.plugins.configs.vim-projectionist").setup,
    keys = require("azvim.plugins.configs.vim-projectionist").keys,
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
    keys = require("azvim.plugins.configs.vim-fugitive").keys,
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
    opts = require("azvim.plugins.configs.gitsigns").opts,
  },

  -- Manage Git Worktrees
  {
    "polarmutex/git-worktree.nvim",
    -- pull from main branch to fix issue with builtin switch
    -- @see https://github.com/polarmutex/git-worktree.nvim/issues/24
    -- version = "^2",
    branch = "main",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = require("azvim.plugins.configs.git-worktree").setup,
  },

  -- Manage GitHub issues and PRs
  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "folke/snacks.nvim",
      "nvim-mini/mini.icons",
    },
    cmd = "Octo",
    config = require("azvim.plugins.configs.octo").setup,
    keys = require("azvim.plugins.configs.octo").keys,
  },

  -- Nicer UI
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = require("azvim.plugins.configs.snacks").opts,
    keys = require("azvim.plugins.configs.snacks").keys,
  },

  {
    "dmtrKovalenko/fff.nvim",
    build = function()
      -- this will download prebuild binary or try to use existing rustup toolchain to build from source
      -- (if you are using lazy you can use gb for rebuilding a plugin if needed)
      require("fff.download").download_or_build_binary()
    end,
    -- if you are using nixos
    -- build = "nix run .#release",
    opts = { -- (optional)
      debug = {
        enabled = true, -- we expect your collaboration at least during the beta
        show_scores = true, -- to help us optimize the scoring system, feel free to share your scores!
      },
    },
    -- No need to lazy-load with lazy.nvim.
    -- This plugin initializes itself lazily.
    lazy = false,
    keys = {
      {
        "ff", -- try it if you didn't it is a banger keybinding for a picker
        function()
          require("fff").find_files()
        end,
        desc = "FFFind files",
      },
    },
  },

  -- todo comments
  {
    "folke/todo-comments.nvim",
    version = "*",
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
    opts = require("azvim.plugins.configs.nvim-spectre").opts,
    keys = require("azvim.plugins.configs.nvim-spectre").keys,
  },

  -- Window resizing
  {
    "anuvyklack/windows.nvim",
    dependencies = {
      "anuvyklack/middleclass",
    },
    config = require("azvim.plugins.configs.windows").setup,
    keys = require("azvim.plugins.configs.windows").keys,
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
    "obsidian-nvim/obsidian.nvim",
    -- hard coded version because completion is broken
    -- @see https://github.com/obsidian-nvim/obsidian.nvim/issues/337
    -- version = "v3.12.0",
    version = "*", -- recommended, use latest release instead of latest commit
    dependencies = {
      "saghen/blink.cmp",
    },
    lazy = true,
    ft = "markdown",
    opts = require("azvim.plugins.configs.obsidian").opts,
    keys = require("azvim.plugins.configs.obsidian").keys,
  },

  -- better markdown formatting
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      file_types = { "markdown" },
    },
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.icons" },
  },

  -- LSP outline sidebar
  {
    "hedyhli/outline.nvim",
    lazy = true,
    cmd = { "Outline", "OutlineOpen" },
    keys = { -- Example mapping to toggle outline
      { "<leader>mo", "<cmd>Outline<CR>", desc = "Toggle outline" },
    },
    opts = {
      symbol_folding = {
        -- Unfold entire symbol tree by default with false, otherwise enter a
        -- number starting from 1
        autofold_depth = false,
        -- autofold_depth = 1,
      },
    },
  },
}
