local project_files = function()
	local ok = pcall(require("telescope.builtin").git_files, { show_untracked = true })

	if not ok then
		require("telescope.builtin").find_files()
	end
end

return {
  "nvim-telescope/telescope.nvim",
  dependencies = { 'nvim-lua/plenary.nvim' },
  cmd = "Telescope",
  keys = {
    { "<leader>ff", project_files, desc = "Files" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
  },
  opts = {
    defaults = {
      mappings = {
        i = {
          ["<C-k>"] = function(...) 
            require("telescope.actions").move_selection_previous(...)
          end, -- move to prev result
          ["<C-j>"] = function(...) 
            require("telescope.actions").move_selection_next(...)
          end, -- move to next result
        },
      }
    }
  }
}

