return {
	"folke/trouble.nvim",
	dependencies = {
		"kyazdani42/nvim-web-devicons",
	},
	opts = {},
	keys = {
		{ "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>" },
		{ "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>" },
		{ "<leader>xq", "<cmd>TroubleToggle quickfix<cr>" },
		{ "<leader>xl", "<cmd>TroubleToggle lsp_references<cr>" },
	},
}
