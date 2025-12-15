local M = {}

function M.setup()
  require("nvim-treesitter").install({
    "bash",
    "c",
    "css",
    "fish",
    "go",
    "gitignore",
    "graphql",
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
    "rust",
    "terraform",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "yaml",
  })
end

return M
