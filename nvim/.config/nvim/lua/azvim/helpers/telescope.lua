local M = {}

M.project_files = function()
	local ok = pcall(require("telescope.builtin").git_files, { show_untracked = true })

	if not ok then
		require("telescope.builtin").find_files()
	end
end

return M
