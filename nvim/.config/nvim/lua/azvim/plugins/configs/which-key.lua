local M = {}

function M.setup()
  local wk = require("which-key")
  wk.setup({
    plugins = { spelling = true },
  })
  wk.add({
    mode = { "n", "v" },
    { "<leader>b", group = "buffer" },
    { "<leader>c", group = "chatgpt" },
    { "<leader>d", group = "debug" },
    { "<leader>da", group = "adapters" },
    { "<leader>f", group = "find" },
    { "<leader>g", group = "git" },
    { "<leader>h", group = "harpoon" },
    { "<leader>k", group = "related" },
    { "<leader>l", group = "lsp" },
    { "<leader>lp", group = "packages" },
    { "<leader>n", group = "notes" },
    { "<leader>o", group = "octo-pr" },
    { "<leader>q", group = "quit" },
    { "<leader>t", group = "test" },
    { "<leader>u", group = "ui" },
    { "<leader>w", group = "window" },
    { "<leader>x", group = "diagnostics" },
    { "g", group = "goto" },
    { "gz", group = "surround" },
  })
end

return M
