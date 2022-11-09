local status_ok, notify = pcall(require, "notify")
if not status_ok then
	return
end

notify.setup({
	background_colour = "#24273A", -- match the Kitty theme (catppuccin)
})

vim.notify = notify
