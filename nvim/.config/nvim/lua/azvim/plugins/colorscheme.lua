return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      transparent_background = true,
      integrations = {
        blink_cmp = true,
        fidget = true,
        harpoon = true,
        lsp_trouble = true,
        mason = true,
        noice = true,
        neotest = true,
        octo = true,
        overseer = true,
        snacks = true,
        telescope = {
          enabled = true,
          style = "nvchad",
        },
        which_key = true,
        render_markdown = true,
      },
      custom_highlights = function(colors)
        return {
          LineNr = { fg = colors.overlay0 },
          PackageInfoOutdatedVersion = { fg = colors.peach },
        }
      end,
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin-nvim")
    end,
  },
}
