local M = {}

function M.opts()
  return {
    search = {
      args = {
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--hidden", -- include hidden files
      },
    },
  }
end

function M.keys()
  return {
    -- stylua: ignore
    { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
    -- stylua: ignore
    { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment", },
    { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
    { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
    { "<leader>fd", "<cmd>TodoTelescope<cr>", desc = "Todo" },
    { "<leader>fD", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
  }
end

return M
