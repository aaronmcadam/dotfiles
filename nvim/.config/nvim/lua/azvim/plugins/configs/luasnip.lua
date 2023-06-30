local M = {}

M.setup = function()
  require("luasnip").setup({
    history = true,
    delete_check_events = "TextChanged",
  })
  require("luasnip/loaders/from_vscode").load({
    paths = vim.fn.stdpath("config") .. "/lua/azvim/snippets",
  })
end

M.keys = function()
  return {
    {
      "<C-y>",
      function()
        return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<C-y>"
      end,
      expr = true,
      silent = true,
      mode = "i",
    },
    {
      "<C-y>",
      function()
        require("luasnip").jump(1)
      end,
      mode = "s",
    },
    {
      "<M-y>",
      function()
        require("luasnip").jump(-1)
      end,
      mode = { "i", "s" },
    },
  }
end

return M
