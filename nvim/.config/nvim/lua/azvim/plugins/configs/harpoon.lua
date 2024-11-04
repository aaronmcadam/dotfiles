local M = {}

function M.setup()
  require("harpoon"):setup()
end

function M.keys()
  local harpoon = require("harpoon")

  return {
    {
      "<leader>ha",
      function()
        harpoon:list():add()
      end,
      desc = "Add Harpoon mark",
    },
    {
      "<leader>hv",
      function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      desc = "View Harpoon marks",
    },
    {
      "<leader>hh",
      function()
        harpoon:list():select(1)
      end,
      desc = "Open Harpoon mark 1",
    },
    {
      "<leader>hj",
      function()
        harpoon:list():select(2)
      end,
      desc = "Open Harpoon mark 2",
    },
    {
      "<leader>hk",
      function()
        harpoon:list():select(3)
      end,
      desc = "Open Harpoon mark 3",
    },
    {
      "<leader>hl",
      function()
        harpoon:list():select(4)
      end,
      desc = "Open Harpoon mark 4",
    },
  }
end

return M
