local M = {}

M.setup = function()
  require("harpoon").setup()
end

M.keys = function()
  local mark = require("harpoon.mark")
  local ui = require("harpoon.ui")

  return {
    {
      "<leader>ha",
      mark.add_file,
      desc = "Add Harpoon mark",
    },
    {
      "<leader>hv",
      ui.toggle_quick_menu,
      desc = "View Harpoon marks",
    },
    {
      "<leader>hh",
      function()
        ui.nav_file(1)
      end,
      desc = "Open Harpoon mark 1",
    },
    {
      "<leader>hj",
      function()
        ui.nav_file(2)
      end,
      desc = "Open Harpoon mark 2",
    },
    {
      "<leader>hk",
      function()
        ui.nav_file(3)
      end,
      desc = "Open Harpoon mark 3",
    },
    {
      "<leader>hl",
      function()
        ui.nav_file(4)
      end,
      desc = "Open Harpoon mark 4",
    },
  }
end

return M
