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
        },
      },
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
        theme = "dropdown",
        additional_args = function()
          -- Dotfiles are getting hidden because they're technically hidden files.
          -- If we set ripgrep to include hidden files, we see too many files that we don't care about.
          -- But ripgrep doesn't seem to support searching hidden files that are tracked by git.
          -- We can filter out git repos though.
          return { "--hidden", "-g", "!.git" }
        end,
      },
      lsp_references = {
        theme = "dropdown",
        fname_width = 100,
      },
      oldfiles = {
        theme = "dropdown",
      },
    },
    extensions = {
      ["zf-native"] = {
        file = { -- options for sorting file-like items
          enable = true, -- override default telescope file sorter
          highlight_results = true, -- highlight matching text in results
          match_filename = true, -- enable zf filename match priority
        },
        generic = { -- options for sorting all other items
          enable = true, -- override default telescope generic item sorter
          highlight_results = true, -- highlight matching text in results
          match_filename = false, -- disable zf filename match priority
        },
      },
      smart_open = {
        cwd_only = true,
        filename_first = true,
      },
    },
  })

  telescope.load_extension("harpoon")
  telescope.load_extension("smart_open")
  telescope.load_extension("undo")
  telescope.load_extension("zf-native")
end

function M.keys()
  return {
    {
      "<leader>ff",
      "<cmd>lua require('telescope').extensions.smart_open.smart_open()<CR>",
      desc = "Find Files",
    },
    { "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<CR>", desc = "Find Buffers" },
    { "<leader>fh", "<cmd>Telescope harpoon marks<CR>", desc = "Find Harpoon Marks" },
    {
      "<leader>fs",
      "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>",
      desc = "Find Document Symbols",
    },
    {
      "<leader>ft",
      "<cmd>lua require('telescope.builtin').live_grep()<CR>",
      desc = "Find Text",
    },
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
