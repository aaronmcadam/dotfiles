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
    theme = "catppuccin"
  },
  sections = {
    lualine_c = {
      { 'filename' },
      { navic.get_location, cond = navic.is_available },
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
