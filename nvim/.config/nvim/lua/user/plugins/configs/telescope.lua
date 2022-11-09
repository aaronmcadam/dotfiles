local telescope_setup, telescope = pcall(require, "telescope")
if not telescope_setup then
	return
end

local actions_setup, actions = pcall(require, "telescope.actions")
if not actions_setup then
	return
end

telescope.setup({
	defaults = {
		mappings = {
			i = {
				["<C-k>"] = actions.move_selection_previous, -- move to prev result
				["<C-j>"] = actions.move_selection_next, -- move to next result
			},
		},
	},
	pickers = {
		live_grep = {
			additional_args = function()
				-- Dotfiles are getting hidden because they're technically hidden files.
				-- If we set ripgrep to include hidden files, we see too many files that we don't care about.
				-- But ripgrep doesn't seem to support searching hidden files that are tracked by git.
				-- We can filter out git repos though.
				return { "--hidden", "-g", "!.git" }
			end,
		},
	},
})

telescope.load_extension("fzf")
telescope.load_extension("harpoon")
telescope.load_extension("notify")

local M = {}

-- We want to see some hidden files that are tracked by git,
-- but showing all hidden files shows too many, such as files within `.git`.
-- We fall back to find_files if git_files fails when there's no `.git` directory.
M.project_files = function()
	local ok = pcall(require("telescope.builtin").git_files, { show_untracked = true })

	if not ok then
		require("telescope.builtin").find_files()
	end
end

return M
