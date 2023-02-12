local catppuccin_status_ok, catppuccin = pcall(require, "catppuccin")
if not catppuccin_status_ok then
	return
end

local colors = require("catppuccin.palettes").get_palette()
colors.none = "NONE"

vim.g.catppuccin_flavour = "macchiato"

catppuccin.setup({
	transparent_background = true,
	custom_highlights = {
		Comment = { fg = colors.overlay1 },
		LineNr = { fg = colors.overlay1 },
		CursorLine = { bg = colors.none },
		CursorLineNr = { fg = colors.lavender },
		DiagnosticVirtualTextError = { bg = colors.none },
		DiagnosticVirtualTextWarn = { bg = colors.none },
		DiagnosticVirtualTextInfo = { bg = colors.none },
		DiagnosticVirtualTextHint = { bg = colors.none },
		HarpoonWindow = { ctermbg = 238 },
		HarpoonBorder = { fg = "#8AADF4" },
	},
	integrations = {
		cmp = true,
		gitsigns = true,
		telescope = true,
		treesitter = true,

		-- Special integrations, see https://github.com/catppuccin/nvim#special-integrations
		navic = {
			enabled = true,
			custom_bg = "NONE",
		},
	},
})

local colorscheme = "catppuccin"

local colorscheme_status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not colorscheme_status_ok then
	vim.notify("colorscheme " .. colorscheme .. " not found!")
	return
end
