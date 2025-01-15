local M = {}

function M.opts()
  local helpers = require("azvim.core.helpers")

  return {
    options = {
      theme = "auto",
      component_separators = { left = "│", right = "│" },
      section_separators = { left = "", right = "" },
      globalstatus = true,
      refresh = {
        statusline = 100,
      },
      disabled_filetypes = {
        statusline = { "dashboard", "alpha" },
      },
    },
    sections = {
      lualine_a = {
        "fancy_mode",
      },
      lualine_b = {
        { "fancy_branch" },
        { "fancy_diff" },
        {
          "filename",
          path = 1,
          symbols = {
            modified = "  ",
            readonly = "",
            unnamed = "",
          },
        },
        {
          function()
            return require("nvim-navic").get_location()
          end,
        },
      },
      lualine_c = {},
      lualine_x = {},
      lualine_y = {
        { "fancy_macro" },
        { "fancy_diagnostics" },
        { "fancy_searchcount" },
        {
          require("lazy.status").updates,
          cond = require("lazy.status").has_updates,
          color = helpers.fg("Special"),
        },
        { "fancy_location" },
        { "fancy_filetype" },
      },
      lualine_z = {},
    },
    extensions = {
      "fugitive",
      "lazy",
      "trouble",
    },
  }
end

return M
