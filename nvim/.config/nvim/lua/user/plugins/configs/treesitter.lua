local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

configs.setup({
	ensure_installed = {
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
	autopairs = {
		enable = true,
	},
	autotag = {
		enable = true,
	},
})
