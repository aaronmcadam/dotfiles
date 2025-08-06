local M = {}

function M.opts()
  local prettier = { "prettierd", "prettier", stop_after_first = true }

  return {
    formatters_by_ft = {
      css = prettier,
      html = prettier,
      javascript = prettier,
      javascriptreact = prettier,
      json = prettier,
      lua = { "stylua" },
      -- markdown = { "markdownlint-cli2" },
      markdown = prettier,
      typescript = prettier,
      typescriptreact = prettier,
      yaml = prettier,
      -- Use the "_" filetype to run formatters on filetypes that don't
      -- have other formatters configured.
      ["_"] = { "trim_whitespace" },
    },
    format_on_save = {
      -- It's safer for now to turn off async formatting
      -- because it could lead to strange behavior such as
      -- updating the buffer text in unpredictable ways.
      async = false,
      lsp_fallback = true,
      timeout_ms = 1000,
    },
  }
end

return M