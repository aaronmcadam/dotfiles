local M = {}

function M.setup()
  local lint = require("lint")

  lint.linters_by_ft = {
    javascript = { "eslint" },
    typescript = { "eslint" },
    javascriptreact = { "eslint" },
    typescriptreact = { "eslint" },
    markdown = { "markdownlint-cli2" },
  }

  local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

  vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
    group = lint_augroup,
    callback = function()
      -- Avoid error messages, such as: "Error running eslint: ENOENT: no such file or directory"
      -- @see https://github.com/mfussenegger/nvim-lint/issues/454
      lint.try_lint(nil, { ignore_errors = true })
    end,
  })
end

return M