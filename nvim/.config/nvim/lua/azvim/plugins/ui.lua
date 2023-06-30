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

  -- Telescope
  {
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
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
    {
      "folke/which-key.nvim",
      event = "VeryLazy",
      opts = {
        plugins = { spelling = true },
        defaults = {
          mode = { "n", "v" },
          ["g"] = { name = "+goto" },
          ["gz"] = { name = "+surround" },
          ["<leader>b"] = { name = "+buffer" },
          ["<leader>f"] = { name = "+find" },
          -- ["<leader>h"] = { name = "+harpoon" },
          ["<leader>g"] = { name = "+git" },
          -- ["<leader>k"] = { name = "+related" },
          -- ["<leader>l"] = { name = "+lsp" },
          ["<leader>q"] = { name = "+quit" },
          -- ["<leader>t"] = { name = "+test" },
          -- ["<leader>x"] = { name = "+diagnostics" },
        },
      },
      config = function(_, opts)
        local wk = require("which-key")
        wk.setup(opts)
        wk.register(opts.defaults)
      end,
    },
  }
}
