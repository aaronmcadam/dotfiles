local M = {}

M.setup = function(_, opts)
  local wk = require("which-key")
  wk.setup(opts)
  wk.register(opts.defaults)
end

M.opts = function()
  return {
    plugins = { spelling = true },
    defaults = {
      mode = { "n", "v" },
      ["g"] = { name = "+goto" },
      ["gz"] = { name = "+surround" },
      ["<leader>b"] = { name = "+buffer" },
      ["<leader>d"] = { name = "+debug" },
      ["<leader>da"] = { name = "+adapters" },
      ["<leader>f"] = { name = "+find" },
      ["<leader>h"] = { name = "+harpoon" },
      ["<leader>g"] = { name = "+git" },
      ["<leader>k"] = { name = "+related" },
      ["<leader>l"] = { name = "+lsp" },
      ["<leader>q"] = { name = "+quit" },
      ["<leader>t"] = { name = "+test" },
      ["<leader>x"] = { name = "+diagnostics" },
    },
  }
end

return M
