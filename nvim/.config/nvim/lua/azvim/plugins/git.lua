return {
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
}
