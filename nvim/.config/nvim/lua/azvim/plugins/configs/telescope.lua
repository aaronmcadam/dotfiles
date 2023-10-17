local M = {}

function M.setup()
  local telescope = require("telescope")
  local actions = require("telescope.actions")
  local sorter = require("mini.fuzzy").get_telescope_sorter

  telescope.setup({
    defaults = {
      mappings = {
        i = {
          ["<C-k>"] = actions.move_selection_previous, -- move to prev result
          ["<C-j>"] = actions.move_selection_next, -- move to next result
        },
      },
      file_sorter = sorter,
      generic_sorter = sorter,
      path_display = { "smart" },
    },
    pickers = {
      find_files = {
        theme = "dropdown",
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

  telescope.load_extension("harpoon")
  telescope.load_extension("undo")
end

function M.keys()
  return {
    { "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<CR>", desc = "Find Files" },
    { "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<CR>", desc = "Find Buffers" },
    { "<leader>fh", "<cmd>Telescope harpoon marks<CR>", desc = "Find Harpoon Marks" },
    {
      "<leader>fs",
      "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>",
      desc = "Find Document Symbols",
    },
    { "<leader>ft", "<cmd>lua require('telescope.builtin').live_grep()<CR>", desc = "Find Text" },
    { "<leader>fu", "<cmd>Telescope undo<CR>", desc = "Find Undo Tree" },
    {
      "<leader>fw",
      "<cmd>lua require('telescope.builtin').grep_string()<CR>",
      desc = "Find Word Under Cursor",
    },
    { "gs", "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>", desc = "Jump to definition" },
    {
      "gv",
      "<cmd>lua require('telescope.builtin').lsp_definitions({ jump_type='vsplit' })<CR>",
      desc = "Jump to definition in vsplit",
    },
  }
end

return M
