local M = {}

function M.setup()
  require("other-nvim").setup({
    rememberBuffers = false,
    mappings = {
      "rails",
      {
        pattern = "/(.*)/(.*).ts(.*)$",
        target = {
          {
            target = "/%1/%2.test.ts%3",
            context = "test",
          },
          {
            target = "/%1/%2.stories.tsx",
            context = "story",
          },
        },
      },
      {
        pattern = "/(.*)/(.*).test.ts(.*)$",
        target = {
          {
            target = "/%1/%2.ts%3",
            context = "implementation",
          },
          {
            target = "/%1/%2.stories.tsx",
            context = "story",
          },
        },
      },
      {
        pattern = "/(.*)/(.*).stories.tsx$",
        target = {
          {
            target = "/%1/%2.tsx",
            context = "implementation",
          },
          {
            target = "/%1/%2.test.tsx",
            context = "test",
          },
        },
      },
    },
  })
end

function M.keys()
  return {
    { "<leader>kk", "<cmd>Other<CR>", desc = "Open related file" },
    { "<leader>kv", "<cmd>OtherVSplit<CR>", desc = "Open related file in split" },
    { "<leader>kt", "<cmd>OtherVSplit test<CR>", desc = "Open test" },
    { "<leader>ks", "<cmd>OtherVSplit story<CR>", desc = "Open story" },
    { "<leader>ki", "<cmd>OtherVSplit implementation<CR>", desc = "Open implementation" },
    { "<leader>kc", "<cmd>OtherClear<CR>", desc = "Clear related files" },
  }
end

return M
