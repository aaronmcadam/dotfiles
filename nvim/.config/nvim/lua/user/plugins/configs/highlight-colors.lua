local status_ok, highlight_colors = pcall(require, "nvim-highlight-colors")
if not status_ok then
	return
end

highlight_colors.setup({
	enable_tailwind = true,
})