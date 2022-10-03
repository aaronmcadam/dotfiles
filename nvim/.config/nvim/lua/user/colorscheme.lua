local catppuccin_status_ok, catppuccin = pcall(require, "catppuccin")
if not catppuccin_status_ok then
  return
end

vim.g.catppuccin_flavour = "macchiato"

catppuccin.setup({
  transparent_background = true,
  integrations = {
    cmp = true,
    gitsigns = true,
    telescope = true,
    treesitter = true,

		-- Special integrations, see https://github.com/catppuccin/nvim#special-integrations
    navic = {
      enabled = true,
      custom_bg = "NONE",
    },
  }
})

local colorscheme = "catppuccin"

local colorscheme_status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not colorscheme_status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
