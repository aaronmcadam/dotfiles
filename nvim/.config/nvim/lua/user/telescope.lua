local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

telescope.setup({
  pickers = {
    find_files = {
      theme = "ivy",
    },
    git_files = {
      theme = "ivy",
    },
    live_grep = {
      theme = "ivy"
    },
    grep_string = {
      theme = "ivy"
    },
    buffers = {
      theme = "ivy"
    }
  },
  extensions = {
    file_browser = {
      theme = "ivy",
      -- show hidden files
      hidden = true,
      -- Open browser from within the folder of the current buffer
      path = "%:p:h",
      -- Open in normal mode by default
      initial_mode = "normal"
    }
  }
})

telescope.load_extension("fzf")
telescope.load_extension("file_browser")
telescope.load_extension("harpoon")

local M = {}

-- We want to see some hidden files that are tracked by git, but showing all
-- hidden files shows too many, such as files within `.git`.
-- We fall back to find_files if git_files fails when there's no `.git` directory.
M.project_files = function()
  local ok = pcall(require("telescope.builtin").git_files, { show_untracked = true })

  if not ok then require("telescope.builtin").find_files() end
end

return M
