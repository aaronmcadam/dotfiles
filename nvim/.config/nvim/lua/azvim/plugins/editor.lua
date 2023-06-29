return {
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
	-- better diagnostics list and others
	{
		"folke/trouble.nvim",
		cmd = { "TroubleToggle", "Trouble" },
		opts = { use_diagnostic_signs = true },
		keys = {
			{ "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
			{ "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
			{ "<leader>xL", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
			{ "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
			{
				"[q",
				function()
					if require("trouble").is_open() then
						require("trouble").previous({ skip_groups = true, jump = true })
					else
						local ok, err = pcall(vim.cmd.cprev)
						if not ok then
							vim.notify(err, vim.log.levels.ERROR)
						end
					end
				end,
				desc = "Previous trouble/quickfix item",
			},
			{
				"]q",
				function()
					if require("trouble").is_open() then
						require("trouble").next({ skip_groups = true, jump = true })
					else
						local ok, err = pcall(vim.cmd.cnext)
						if not ok then
							vim.notify(err, vim.log.levels.ERROR)
						end
					end
				end,
				desc = "Next trouble/quickfix item",
			},
		},
	},
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
	-- which-key
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
				["<leader>h"] = { name = "+harpoon" },
				["<leader>g"] = { name = "+git" },
				["<leader>k"] = { name = "+related" },
				["<leader>l"] = { name = "+lsp" },
				["<leader>q"] = { name = "+quit" },
				["<leader>t"] = { name = "+test" },
				["<leader>x"] = { name = "+diagnostics" },
			},
		},
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)
			wk.register(opts.defaults)
		end,
	},
}
