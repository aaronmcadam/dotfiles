local M = {}

-- inspired by https://github.com/nvim-neotest/neotest/pull/217#issuecomment-1454851348
local neotest_status = function()
  local status_ok, neotest = pcall(require, "neotest")
  if not status_ok then
    return ""
  end
  local adapters = neotest.state.adapter_ids()
  if #adapters > 0 then
    local status = neotest.state.status_counts(adapters[1], {
      buffer = vim.api.nvim_buf_get_name(0),
    })
    local sections = {
      {
        sign = "",
        count = status.failed,
        base = "NeotestFailed",
        tag = "test_fail",
      },
      {
        sign = "",
        count = status.running,
        base = "NeotestRunning",
        tag = "test_running",
      },
      {
        sign = "",
        count = status.passed,
        base = "NeotestPassed",
        tag = "test_pass",
      },
    }

    local result = {}
    for _, section in ipairs(sections) do
      if section.count > 0 then
        table.insert(result, "%#" .. section.base .. "#" .. section.sign .. " " .. section.count)
      end
    end

    return table.concat(result, " ")
  end
  return ""
end

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
        statusline = { "snacks_dashboard" },
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
        { neotest_status },
        {
          require("package-info").get_status,
          color = helpers.fg("Statement"),
        },
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
