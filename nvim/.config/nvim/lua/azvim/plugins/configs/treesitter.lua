local M = {}

function M.setup()
  require("nvim-treesitter.configs").setup({
    textobjects = {
      select = {
        enable = true,
        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,
        keymaps = {
          ["af"] = { query = "@call.outer", desc = "Select outer part of a function call" },
          ["if"] = { query = "@call.inner", desc = "Select inner part of a function call" },

          ["am"] = { query = "@function.outer", desc = "Select outer part of a method/function definition" },
          ["im"] = { query = "@function.inner", desc = "Select inner part of a method/function definition" },
        },
      },
    },
    ensure_installed = {
      "bash",
      "c",
      "css",
      "fish",
      "go",
      "gitignore",
      "html",
      "java",
      "javascript",
      "json",
      "lua",
      "markdown",
      "markdown_inline",
      "hcl",
      "ruby",
      "terraform",
      "tsx",
      "typescript",
      "vimdoc",
      "yaml",
    },
    highlight = {
      enable = true, -- false will disable the whole extension
    },
    indent = {
      enable = true,
    },
    matchup = {
      enable = true,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-tab>",
        node_incremental = "<C-tab>",
        scope_incremental = false,
        node_decremental = "<bs>",
      },
    },
  })
end

return M
