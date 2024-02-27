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
  {
    "b0o/incline.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    event = "VeryLazy",
    config = function()
      local helpers = require("incline.helpers")
      local devicons = require("nvim-web-devicons")
      require("incline").setup({
        window = {
          padding = 0,
          margin = { horizontal = 0 },
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if filename == "" then
            filename = "[No Name]"
          end
          local ft_icon, ft_color = devicons.get_icon_color(filename)
          local modified = vim.bo[props.buf].modified
          return {
            ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or "",
            " ",
            { filename, gui = modified and "bold,italic" or "bold" },
            " ",
            guibg = "#44406e",
          }
        end,
      })
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
      "natecraddock/telescope-zf-native.nvim",
      {
        "danielfalk/smart-open.nvim",
        branch = "0.2.x",
        dependencies = {
          "kkharji/sqlite.lua",
          "nvim-telescope/telescope-fzy-native.nvim",
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
      -- "rcarriga/nvim-notify",
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
    opts = {
      workspaces = {
        {
          name = "Remote Second Brain",
          path = "~/Documents/Remote Second Brain/",
        },
      },
      notes_subdir = "30 Areas/31 Inbox",
      new_notes_location = "notes_subdir",
      templates = {
        subdir = "50 Resources/54 Templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
      },
      daily_notes = {
        folder = "40 Journal/41 Daily Notes/2024",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
        template = "OTPL Daily Note.md",
      },
      -- Optional, set to true to force ':ObsidianOpen' to bring the app to the foreground.
      open_app_foreground = true,
      -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
      -- URL it will be ignored but you can customize this behavior here.
      ---@param url string
      follow_url_func = function(url)
        -- Open the URL in the default web browser.
        vim.fn.jobstart({ "open", url }) -- Mac OS
        -- vim.fn.jobstart({"xdg-open", url})  -- linux
      end,
      note_id_func = function(title)
        return title
      end,
      note_frontmatter_func = function(note)
        -- Add the title of the note as an alias.
        if note.title then
          note:add_alias(note.title)
        end

        local out = { aliases = note.aliases, tags = note.tags }

        -- `note.metadata` contains any manually added fields in the frontmatter.
        -- So here we just make sure those fields are kept in the frontmatter.
        if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
          for k, v in pairs(note.metadata) do
            out[k] = v
          end
        end

        return out
      end,
      -- Optional, customize the default name or prefix when pasting images via `:ObsidianPasteImg`.
      ---@return string
      image_name_func = function()
        -- Prefix image names with timestamp.
        return string.format("%s-", os.time())
      end,
      attachments = {
        -- The default folder to place images in via `:ObsidianPasteImg`.
        -- If this is a relative path it will be interpreted as relative to the vault root.
        -- You can always override this per image by passing a full path to the command instead of just a filename.
        img_folder = "50 Resources/51 Attachments",
      },
    },
    keys = {
      {
        "<leader>nb",
        "<cmd>ObsidianBacklinks<cr>",
        desc = "Show backlinks for current note",
      },
      {
        "<leader>nd",
        "<cmd>ObsidianToday<cr>",
        desc = "Open new Daily Note",
      },
      {
        "<leader>nf",
        "<cmd>ObsidianFollowLink<cr>",
        desc = "Follow link",
      },
      {
        "<leader>nn",
        "<cmd>ObsidianNew<cr>",
        desc = "Create new note",
      },
      {
        "<leader>no",
        "<cmd>ObsidianOpen<cr>",
        desc = "Open note in Obsidian",
      },
      {
        "<leader>nll",
        "<cmd>ObsidianLink<cr>",
        desc = "Link selection",
      },
      {
        "<leader>nln",
        "<cmd>ObsidianLinkNew<cr>",
        desc = "Create and link new note",
      },
      {
        "<leader>nq",
        "<cmd>ObsidianQuickSwitch<cr>",
        desc = "Switch to another note",
      },
      {
        "<leader>ns",
        "<cmd>ObsidianSearch<cr>",
        desc = "Search notes",
      },
      {
        "<leader>nt",
        "<cmd>ObsidianTemplate<cr>",
        desc = "Insert template",
      },
      {
        "<leader>ny",
        "<cmd>ObsidianYesterday<cr>",
        desc = "Open yesterday's Daily Note",
      },
    },
  },

  -- for writing prose
  {
    "preservim/vim-pencil",
  },

  -- ChatGPT
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    config = function()
      require("chatgpt").setup({
        popup_input = {
          submit = "<CR>",
          -- submit = "<C-s>",
        },
      })
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },
}
