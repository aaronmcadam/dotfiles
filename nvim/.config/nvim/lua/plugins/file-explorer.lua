return {
  'stevearc/oil.nvim',
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {},
  keys = {
    {
      "-", "<cmd>lua require('oil').open()<CR>", desc = "Open parent directory"
    }
  },
}
