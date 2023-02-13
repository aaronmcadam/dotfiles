local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

lualine.setup({
	options = {
		theme = "catppuccin",
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			"alpha",
		},
	},
	sections = {
		lualine_a = {
			{ "mode", separator = { left = "" }, right_padding = 2 },
		},
		lualine_c = {
			-- @see https://github.com/nvim-lualine/lualine.nvim#filename-component-options
			{ "filename", path = 1 },
		},
	},
})
