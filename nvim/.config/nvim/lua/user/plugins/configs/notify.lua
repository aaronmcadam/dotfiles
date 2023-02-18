local status_ok, notify = pcall(require, "notify")
if not status_ok then
	return
end

notify.setup({
	background_colour = "#24273A", -- match the Kitty theme (catppuccin)
})

-- Inspired by https://github.com/rcarriga/nvim-notify/issues/114
local banned_messages = { "No information available" }

---@diagnostic disable-next-line: duplicate-set-field
vim.notify = function(msg, ...)
	for _, banned in ipairs(banned_messages) do
		if msg == banned then
			return
		end
	end

	notify(msg, ...)
end
