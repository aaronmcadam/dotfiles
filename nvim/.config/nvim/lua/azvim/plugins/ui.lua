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

	-- Fancier statusline
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("lualine").setup({
				options = {
					theme = "auto",
					disabled_filetypes = { "alpha" },
				},
			})
		end,
	},

	-- buffer line
	{
		"akinsho/bufferline.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = {
			options = {
				always_show_bufferline = false,
			},
		},
	},

	-- harpoon
	{
		"ThePrimeagen/harpoon",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{
				"<leader>ha",
				function()
					require("harpoon.mark").add_file()
				end,
				desc = "Add Harpoon mark",
			},
			{
				"<leader>hh",
				function()
					require("harpoon.ui").toggle_quick_menu()
				end,
				desc = "View Harpoon marks",
			},
		},
		config = function()
			require("harpoon").setup()
		end,
	},

	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"ThePrimeagen/harpoon",
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
	},

	-- Better `vim.notify()`
	{
		"rcarriga/nvim-notify",
		keys = {
			{
				"<leader>un",
				function()
					require("notify").dismiss({ silent = true, pending = true })
				end,
				desc = "Dismiss all Notifications",
			},
		},
		opts = {
			timeout = 3000,
			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.75)
			end,
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
			{ "<leader>gg", "<cmd>Git<CR>", desc = "Git" },
			{ "<leader>gb", "<cmd>GBrowse<CR>", desc = "Git Browse" },
			{ "<leader>gd", "<cmd>Gvdiffsplit<CR>", desc = "Git Diff" },
			{ "<leader>gp", "<cmd>G push<CR>", desc = "Git Push" },
			{ "<leader>gr", "<cmd>Gread<CR>", desc = "Git Read" },
			{ "<leader>gw", "<cmd>Gwrite<CR>", desc = "Git Write" },
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {},
	},

	-- indent guides for Neovim
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			char = "│",
			filetype_exclude = {
				"help",
				"alpha",
				"dashboard",
				"neo-tree",
				"Trouble",
				"lazy",
				"mason",
				"notify",
				"toggleterm",
				"lazyterm",
			},
			show_trailing_blankline_indent = false,
			show_current_context = false,
		},
	},
}
