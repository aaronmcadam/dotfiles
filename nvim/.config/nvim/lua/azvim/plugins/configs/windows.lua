local M = {}

function M.setup()
  require("windows").setup()
end

function M.keys()
  return {
    {
      "<leader>zz",
      "<cmd>WindowsMaximize<CR>",
      desc = "Maximize Window",
    },
    {
      "<leader>zv",
      "<cmd>WindowsMaximizeVertically<CR>",
      desc = "Maximize Window Vertically",
    },
    {
      "<leader>zh",
      "<cmd>WindowsMaximizeHorizontally<CR>",
      desc = "Maximize Window Horizontally",
    },
    {
      "<leader>ze",
      "<cmd>WindowsEqualize<CR>",
      desc = "Equalize all Windows",
    },
    {
      "<leader>zt",
      "<cmd>WindowsToggleAutowidth<CR>",
      desc = "Toggle Windows Auto-width",
    },
  }
end

return M