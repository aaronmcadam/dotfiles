local M = {}

function M.keys()
  local flash_status_ok, flash = pcall(require, "flash")
  if not flash_status_ok then
    return
  end
  return {
    {
      "s",
      mode = { "n", "x", "o" },
      flash.jump,
      desc = "Flash",
    },
    {
      "S",
      mode = { "n", "o", "x" },
      flash.treesitter,
      desc = "Flash Treesitter",
    },
    {
      "r",
      mode = "o",
      flash.remote,
      desc = "Remote Flash",
    },
    {
      "R",
      mode = { "o", "x" },
      flash.treesitter_search,
      desc = "Flash Treesitter Search",
    },
    {
      "<c-s>",
      mode = { "c" },
      flash.toggle,
      desc = "Toggle Flash Search",
    },
  }
end

return M
