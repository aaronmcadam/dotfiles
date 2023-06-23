return {
	"folke/tokyonight.nvim",
	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	priority = 1000, -- make sure to load this before all the other start plugins
	config = function()
		require("tokyonight").setup({
			transparent = true,
			on_highlights = function(hl, c)
				hl.CursorLineNr = {
					fg = c.orange,
					bold = true,
				}
				hl.LineNr = {
					fg = c.blue,
				}
			end,
		})

		-- load the colorscheme here
		vim.cmd([[colorscheme tokyonight]])
	end,
}
