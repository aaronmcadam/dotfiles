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
      ["<leader>c"] = { name = "+chatgpt" },
      ["<leader>d"] = { name = "+debug" },
      ["<leader>da"] = { name = "+adapters" },
      ["<leader>f"] = { name = "+find" },
      ["<leader>h"] = { name = "+harpoon" },
      ["<leader>g"] = { name = "+git" },
      ["<leader>k"] = { name = "+related" },
      ["<leader>l"] = { name = "+lsp" },
      ["<leader>lp"] = { name = "+packages" },
      ["<leader>o"] = { name = "+octo-pr" },
      ["<leader>n"] = { name = "+notes" },
      ["<leader>q"] = { name = "+quit" },
      ["<leader>t"] = { name = "+test" },
      ["<leader>u"] = { name = "+ui" },
      ["<leader>w"] = { name = "+window" },
      ["<leader>x"] = { name = "+diagnostics" },
    },
  }
end

return M
