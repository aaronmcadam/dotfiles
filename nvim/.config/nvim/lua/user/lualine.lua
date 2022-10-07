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
  winbar = {
    lualine_a = {
      { navic.get_location, cond = navic.is_available },
    }
  }
})
