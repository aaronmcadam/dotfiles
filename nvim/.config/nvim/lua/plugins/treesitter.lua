return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = { "windwp/nvim-ts-autotag" },
  build = ":TSUpdate",
  event = "BufReadPost",
  config = function()
    require("nvim-treesitter.configs").setup({
      opts = {
        ensure_installed = {
          "bash",
          "css",
          "fish",
          "html",
          "javascript",
          "json",
          "lua",
          "markdown",
          "markdown_inline",
          "hcl",
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
        autopairs = {
          enable = true,
        },
        autotag = {
          enable = true,
        },
      }
    })
  end
}
