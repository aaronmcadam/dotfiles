local project_files = function()
	local ok = pcall(require("telescope.builtin").git_files, { show_untracked = true })

	if not ok then
		require("telescope.builtin").find_files()
	end
end

return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
		{
			"ahmedkhalf/project.nvim",
			config = function()
				require("project_nvim").setup()
			end,
		},
	},
	cmd = "Telescope",
	keys = {
		{ "<leader>ff", project_files, desc = "Find Files" },
		{ "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<CR>", desc = "Find Buffers" },
		{ "<leader>ft", "<cmd>lua require('telescope.builtin').live_grep()<CR>", desc = "Find Text" },
		{ "gs", "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>", desc = "Jump to definition" },
		{
			"gv",
			"<cmd>lua require('telescope.builtin').lsp_definitions({ jump_type='vsplit' })<CR>",
			desc = "Jump to definition in vsplit",
		},
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

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
				find_files = {
					theme = "dropdown",
				},
				git_files = {
					theme = "dropdown",
				},
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
		telescope.load_extension("projects")
	end,
}
