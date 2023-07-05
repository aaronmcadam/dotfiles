return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      transparent_background = true,
      integrations = {
        alpha = true,
        fidget = true,
        harpoon = true,
        lsp_trouble = true,
        mason = true,
        navic = {
          enabled = true,
        },
        noice = true,
        neotest = true,
        notify = true,
        telescope = true,
        treesitter = true,
        which_key = true,
      },
    },
    init = function()
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
