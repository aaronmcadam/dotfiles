local M = {}

function M.setup()
  require("harpoon").setup()
end

function M.keys()
  -- The dependencies might not be installed when this function is called.
  -- For example, on a fresh install.
  -- So, we can load dependencies using pcall instead of directly requiring.
  local mark_status_ok, mark = pcall(require, "harpoon.mark")
  if not mark_status_ok then
    return
  end
  local ui_status_ok, ui = pcall(require, "harpoon.ui")
  if not ui_status_ok then
    return
  end

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
