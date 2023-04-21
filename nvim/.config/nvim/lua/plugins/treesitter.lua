return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = "BufReadPost",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"astro",
				"bash",
				"css",
				"fish",
				"html",
				"javascript",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				"hcl",
				"terraform",
				"tsx",
				"typescript",
				"yaml",
			},
			highlight = {
				enable = true, -- false will disable the whole extension
			},
			indent = {
				enable = true,
			},
		})
	end,
}