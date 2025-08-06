local M = {}

function M.setup()
  -- Borrowed ideas from:
  -- https://github.com/akinsho/dotfiles/blob/d81e2f0cd00d71170107ed30db34fc644173a411/.config/nvim/lua/as/plugins/projects.lua#L2
  vim.g.projectionist_heuristics = {
    ["*"] = {
      ["*.ts"] = {
        alternate = "{}.test.ts",
        type = "source",
      },
      ["*.tsx"] = {
        alternate = { "{}.test.tsx", "{}.stories.tsx", "{}.stories.ts" },
        type = "component",
      },
      ["*.test.ts"] = {
        alternate = "{}.ts",
        type = "test",
      },
      ["*.test.tsx"] = {
        alternate = "{}.tsx",
        type = "test",
        template = {
          "import { {basename|camelcase|capitalize} } from './{basename|camelcase|capitalize}';",
          "",
          "describe('{basename|camelcase|capitalize}', () => {open}",
          "  test('renders', () => {open}",
          "    render(<{basename|camelcase|capitalize} />);",
          "    expect(true).toBe(true);",
          "   {close});",
          "{close});",
        },
      },
      ["*.stories.ts"] = {
        alternate = { "{}.tsx", "{}.test.tsx" },
        type = "story",
      },
      ["*.stories.tsx"] = {
        alternate = { "{}.tsx", "{}.test.tsx" },
        type = "story",
      },
    },
  }
end

function M.keys()
  return {
    { "<leader>kk", "<cmd>A<CR>", desc = "Open related file" },
    { "<leader>kv", "<cmd>AV<CR>", desc = "Open related file in split" },
    { "<leader>kt", "<cmd>Vtest<CR>", desc = "Open test" },
    { "<leader>ks", "<cmd>Vstory<CR>", desc = "Open story" },
  }
end

return M