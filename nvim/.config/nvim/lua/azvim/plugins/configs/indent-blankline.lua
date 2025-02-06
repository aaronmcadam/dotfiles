local M = {}

function M.opts()
  return {
    indent = {
      char = "│",
    },
    exclude = {
      filetypes = {
        "help",
        "neo-tree",
        "Trouble",
        "lazy",
        "mason",
        "notify",
        "toggleterm",
        "lazyterm",
      },
    },
    scope = {
      enabled = false,
    },
  }
end

return M
