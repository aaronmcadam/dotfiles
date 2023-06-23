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
}
