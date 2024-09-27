return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      transparent_background = true,
      integrations = {
        fidget = true,
        harpoon = true,
        lsp_trouble = true,
        mason = true,
        navic = {
          enabled = true,
        },
        noice = true,
        neotest = true,
        octo = true,
        overseer = true,
        telescope = {
          enabled = true,
          style = "nvchad",
        },
        which_key = true,
      },
      custom_highlights = function(colors)
        return {
          LineNr = { fg = colors.overlay0 },
          PackageInfoOutdatedVersion = { fg = colors.peach },
        }
      end,
    },
    init = function()
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
