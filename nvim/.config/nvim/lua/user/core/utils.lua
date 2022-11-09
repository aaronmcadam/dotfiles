local M = {}

-- NOTE: I think this only reloads what has already been loaded—it won't find new files.
function M.reload_config()
	require("plenary.reload").reload_module("user")
	dofile(vim.env.MYVIMRC)

	vim.notify("Config reloaded")
end

return M
