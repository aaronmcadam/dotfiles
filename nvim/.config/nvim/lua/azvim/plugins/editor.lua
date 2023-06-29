return {
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
	{
		"folke/trouble.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		opts = {},
		keys = {
			{ "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>" },
			{ "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>" },
			{ "<leader>xq", "<cmd>TroubleToggle quickfix<cr>" },
			{ "<leader>xl", "<cmd>TroubleToggle lsp_references<cr>" },
		},
	},
}
