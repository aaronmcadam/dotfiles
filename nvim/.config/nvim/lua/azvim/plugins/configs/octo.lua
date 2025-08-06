local M = {}

function M.setup()
  require("octo").setup({
    enable_builtin = true,
    picker = "snacks",
  })
end

function M.keys()
  return {
    { "<leader>gh", "<cmd>Octo<CR>", desc = "Open Octo" },
    { "<leader>oo", "<cmd>Octo pr list<CR>", desc = "Octo PR list all" },
    { "<leader>oc", "<cmd>Octo pr create<CR>", desc = "Octo PR create" },
    { "<leader>om", "<cmd>Octo pr merge squash delete<CR>", desc = "Octo PR merge" },
    { "<leader>ov", "<cmd>Octo pr browser<CR>", desc = "Octo PR open in browser" },
    { "<leader>oh", "<cmd>Octo pr checkout<CR>", desc = "Octo PR checkout" },
    { "<leader>ox", "<cmd>Octo pr create draft<CR>", desc = "Octo PR create draft" },
    { "<leader>od", "<cmd>Octo pr diff<CR>", desc = "Octo PR diff" },
    { "<leader>oy", "<cmd>Octo pr url<CR>", desc = "Octo PR copy URL" },
    { "<leader>of", "<cmd>Octo pr changes<CR>", desc = "Octo PR list changed files" },
    { "<leader>oj", "<cmd>Octo pr checks<CR>", desc = "Octo PR checks" },
    { "<leader>ol", "<cmd>Octo pr commits<CR>", desc = "Octo PR list commits" },
    { "<leader>ou", "<cmd>Octo pr reload<CR>", desc = "Octo PR reload" },
    { "<leader>orr", "<cmd>Octo review<CR>", desc = "Octo PR review start" },
    { "<leader>ors", "<cmd>Octo review submit<CR>", desc = "Octo PR review submit" },
    { "<leader>orc", "<cmd>Octo review comments<CR>", desc = "Octo PR review comments" },
  }
end

return M