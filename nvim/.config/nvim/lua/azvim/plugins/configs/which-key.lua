local M = {}

function M.setup()
  local wk = require("which-key")
  wk.add({
    mode = { "n", "v" },
    { "<leader>b", group = "buffer" },
    { "<leader>d", group = "debug" },
    { "<leader>da", group = "adapters" },
    { "<leader>f", group = "find" },
    { "<leader>g", group = "git" },
    { "<leader>h", group = "harpoon" },
    { "<leader>k", group = "related" },
    { "<leader>l", group = "lsp" },
    { "<leader>lp", group = "packages" },
    { "<leader>m", group = "manage" },
    { "<leader>n", group = "notes" },
    { "<leader>o", group = "octo-pr" },
    { "<leader>q", group = "quit" },
    { "<leader>t", group = "test" },
    { "<leader>u", group = "ui" },
    { "<leader>w", group = "window" },
    { "<leader>x", group = "diagnostics" },
    { "g", group = "goto" },
    { "gz", group = "surround" },
  })

  -- Add mini.ai keybindings
  ---@type table<string, string|table>
  local textobjects = {
    [" "] = "Whitespace",
    ['"'] = 'Balanced "',
    ["'"] = "Balanced '",
    ["`"] = "Balanced `",
    ["("] = "Balanced (",
    [")"] = "Balanced ) including white-space",
    [">"] = "Balanced > including white-space",
    ["<lt>"] = "Balanced <",
    ["]"] = "Balanced ] including white-space",
    ["["] = "Balanced [",
    ["}"] = "Balanced } including white-space",
    ["{"] = "Balanced {",
    ["?"] = "User Prompt",
    _ = "Underscore",
    a = "Argument",
    b = "Balanced ), ], }",
    d = "Digit(s)",
    f = "Function",
    g = "Entire file",
    i = "Indent",
    o = "Block, conditional, loop",
    q = "Quote `, \", '",
    r = "Line",
    t = "Tag",
    u = "Use/call function & method",
    U = "Use/call without dot in name",
    x = "Diagnostic",
  }

  local mappings = {
    mode = { "o", "x" }, -- Operator-pending and visual modes
  }
  for key, desc in pairs(textobjects) do
    table.insert(mappings, { "i" .. key, desc = "Inside " .. desc })
    table.insert(mappings, { "a" .. key, desc = "Around " .. desc })
  end

  wk.add(mappings)
end

return M
