local M = {}

function M.setup()
  local colors = require("catppuccin.palettes").get_palette("mocha")
  require("package-info").setup({
    -- autostart = false,
    package_manager = "pnpm",
    colors = {
      outdated = colors.peach,
    },
    hide_up_to_date = true,
  })
end

function M.keys()
  return {
    { "<leader>lpt", "<cmd>lua require('package-info').toggle()<cr>", desc = "Toggle" },
    { "<leader>lpd", "<cmd>lua require('package-info').delete()<cr>", desc = "Delete package" },
    { "<leader>lpu", "<cmd>lua require('package-info').update()<cr>", desc = "Update package" },
    { "<leader>lpi", "<cmd>lua require('package-info').install()<cr>", desc = "Install package" },
    { "<leader>lpc", "<cmd>lua require('package-info').change_version()<cr>", desc = "Change package version" },
  }
end

return M