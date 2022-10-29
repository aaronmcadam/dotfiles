local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

local status_navic_ok, navic = pcall(require, "nvim-navic")
if not status_navic_ok then
  return
end

lualine.setup({
  options = {
    theme = "catppuccin",
    section_separators = { left = '', right = '' },
    disabled_filetypes = {
      winbar = {
        'alpha'
      }
    }
  },
  sections = {
    lualine_a = {
      { 'mode', separator = { left = '' }, right_padding = 2 },
    },
    lualine_c = {
      { 'filename' },
      { navic.get_location, cond = navic.is_available, },
    }
  },
  winbar = {
    lualine_a = {
      { 'filename' },
    }
  },
  inactive_winbar = {
    lualine_a = {
      { 'filename' },
    }
  }
})
