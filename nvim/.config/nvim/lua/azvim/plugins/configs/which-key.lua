local M = {}

function M.setup(_, opts)
  local wk = require("which-key")
  wk.setup(opts)
  wk.register(opts.defaults)
end

function M.opts()
  return {
    plugins = { spelling = true },
    defaults = {
      mode = { "n", "v" },
      ["g"] = { name = "+goto" },
      ["gz"] = { name = "+surround" },
      ["<leader>b"] = { name = "+buffer" },
      ["<leader>c"] = { name = "+leetcode" },
      ["<leader>d"] = { name = "+debug" },
      ["<leader>da"] = { name = "+adapters" },
      ["<leader>f"] = { name = "+find" },
      ["<leader>h"] = { name = "+harpoon" },
      ["<leader>g"] = { name = "+git" },
      ["<leader>k"] = { name = "+related" },
      ["<leader>l"] = { name = "+lsp" },
      ["<leader>q"] = { name = "+quit" },
      ["<leader>t"] = { name = "+test" },
      ["<leader>u"] = { name = "+ui" },
      ["<leader>x"] = { name = "+diagnostics" },
    },
  }
end

return M
