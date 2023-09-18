local M = {}

function M.setup()
  -- get neotest namespace (api call creates or returns namespace)
  local neotest_ns = vim.api.nvim_create_namespace("neotest")
  vim.diagnostic.config({
    virtual_text = {
      format = function(diagnostic)
        local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
        return message
      end,
    },
  }, neotest_ns)
  require("neotest").setup({
    adapters = {
      require("neotest-go"),
      require("neotest-vitest"),
      require("neotest-rspec"),
    },
  })
end

function M.keys()
  return {
    {
      "<leader>tf",
      "<cmd>w<CR><cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>",
      desc = "Test File",
    },
    { "<leader>tt", "<cmd>w<CR><cmd>lua require('neotest').run.run()<CR>", desc = "Test Nearest" },
    { "<leader>tl", "<cmd>w<CR><cmd>lua require('neotest').run.run_last()<CR>", desc = "Test Last" },
    {
      "<leader>to",
      "<cmd>w<CR><cmd>lua require('neotest').output.open()<CR>",
      desc = "Open Test Output",
    },
    {
      "<leader>ts",
      "<cmd>w<CR><cmd>lua require('neotest').output_panel.toggle()<CR>",
      desc = "Toggle Test Summary",
    },
    {
      "<leader>td",
      function()
        vim.cmd("w")
        require("neotest").run.run({ strategy = "dap" })
      end,
      desc = "Debug Nearest",
    },
    -- { "<leader>ts", "<cmd>w<CR><cmd>TestSuite<CR>", desc = "Test Suite" },
    -- { "<leader>tv", "<cmd>w<CR><cmd>TestVisit<CR>", desc = "Test Visit" },
    -- { "<leader>tp", "<cmd>w<CR><cmd>Playwright --project=chromium<CR>", desc = "Playwright" },
    -- { "<leader>th", "<cmd>w<CR><cmd>Playwright --project=chromium --headed<CR>", desc = "Playwright Headed" },
    -- { "<leader>td", "<cmd>w<CR><cmd>Playwright --project=chromium --debug<CR>", desc = "Playwright Debug" },
  }
end

return M
