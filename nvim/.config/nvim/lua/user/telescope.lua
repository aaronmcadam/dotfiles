local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

telescope.setup({
  pickers = {
    find_files = {
    },
    git_files = {
    },
    live_grep = {
      additional_args = function()
        -- Dotfiles are getting hidden because they're technically hidden files.
        -- If we set ripgrep to include hidden files, we see too many files that we don't care about.
        -- But ripgrep doesn't seem to support searching hidden files that are tracked by git.
        -- We can filter out git repos though.
        return { "--hidden", "-g", "!.git" }
      end
    },
    grep_string = {
    },
    buffers = {
    }
  },
  extensions = {
    file_browser = {
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
