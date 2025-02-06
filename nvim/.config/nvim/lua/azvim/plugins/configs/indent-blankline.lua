local M = {}

function M.opts()
  return {
    indent = {
      char = "│",
    },
    exclude = {
      filetypes = {
        "help",
        "Trouble",
        "lazy",
        "mason",
        "notify",
      },
    },
    scope = {
      enabled = false,
    },
  }
end

return M
