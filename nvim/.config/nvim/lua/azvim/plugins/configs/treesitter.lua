local M = {}

M.setup = function()
  require("nvim-treesitter.configs").setup({
    ensure_installed = {
      "bash",
      "c",
      "css",
      "fish",
      "go",
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
      "yaml",
    },
    highlight = {
      enable = true, -- false will disable the whole extension
    },
    indent = {
      enable = true,
    },
  })
end

return M
