local M = {}

function M.keys()
  return {
    { "<leader>gg", "<cmd>Git<CR>", desc = "Git" },
    { "<leader>gv", "<cmd>GBrowse<CR>", desc = "Git View in Browser" },
    { "<leader>gb", "<cmd>G blame<CR>", desc = "Git Blame" },
    { "<leader>gd", "<cmd>Gvdiffsplit!<CR>", desc = "Git Diff" },
    { "<leader>gr", "<cmd>Gread<CR><cmd>update<CR>", desc = "Git Read" },
    { "<leader>gw", "<cmd>Gwrite<CR>", desc = "Git Write" },
    { "<leader>gp", "<cmd>Git push<CR>", desc = "Git Push" },
    { "<leader>gl", "<cmd>Git log<CR>", desc = "Git Log" },
  }
end

return M