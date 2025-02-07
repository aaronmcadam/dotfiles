local M = {}

function M.setup()
  local telescope = require("telescope")
  local actions = require("telescope.actions")

  telescope.setup({
    defaults = {
      mappings = {
        i = {
          ["<C-k>"] = actions.move_selection_previous, -- move to prev result
          ["<C-j>"] = actions.move_selection_next, -- move to next result
          ["<C-u>"] = false, -- let Ctrl + U clear the input
          -- bind scrolling to the same keys as nvim-cmp autocompletion
          ["<C-f>"] = actions.preview_scrolling_down, -- Scroll down (forward).
          ["<C-b>"] = actions.preview_scrolling_up, -- Scroll up (backward).
        },
      },
      path_display = { "filename_first" },
    },
    pickers = {
      find_files = {
        theme = "ivy",
        find_command = {
          "rg",
          "--files",
          "--hidden",
          "--iglob=!{.git,node_modules}/*",
          "--no-ignore-vcs",
          "--glob=!**/.git/*",
          "--glob=!**/node_modules/*",
          "--glob=!**/.next/*",
          "--glob=!**/out/*",
        },
      },
      git_files = {
        theme = "ivy",
      },
      live_grep = {
        theme = "ivy",
        additional_args = function()
          -- Dotfiles are getting hidden because they're technically hidden files.
          -- If we set ripgrep to include hidden files, we see too many files that we don't care about.
          -- But ripgrep doesn't seem to support searching hidden files that are tracked by git.
          -- We can filter out git repos though.
          return { "--hidden", "-g", "!.git" }
        end,
      },
      lsp_references = {
        theme = "ivy",
        fname_width = 100,
      },
      oldfiles = {
        theme = "ivy",
      },
      package_info = {
        theme = "ivy",
      },
    },
    extensions = {
      package_info = {
        theme = "ivy",
      },
    },
  })

  telescope.load_extension("fzf")
  telescope.load_extension("package_info")
end

function M.keys()
  return {
    {
      "<leader>fp",
      "<cmd>Telescope package_info<CR>",
      desc = "Open [p]ackage info menu",
    },
  }
end

return M
