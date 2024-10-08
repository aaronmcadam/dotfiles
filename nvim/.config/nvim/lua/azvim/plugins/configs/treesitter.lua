local M = {}

function M.setup()
  require("nvim-treesitter.configs").setup({
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
      "kdl",
      "lua",
      "markdown",
      "markdown_inline",
      "hcl",
      "regex",
      "ruby",
      "terraform",
      "toml",
      "tsx",
      "typescript",
      "vim",
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
