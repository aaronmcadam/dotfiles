local M = {}

function M.opts()
  return {
    dashboard = {
      enabled = true,
      preset = {
        keys = {
          { icon = "󰈞 ", key = "f", desc = "Find File", action = "<leader>ff" },
          { icon = "󰈔 ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = "󰊢 ", key = "s", desc = "Git", action = ":Git | only" },
          { icon = "󰱼 ", key = "w", desc = "Find Text", action = "<leader>ft" },
          { icon = "󰋚 ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          {
            icon = "󰒓 ",
            key = "c",
            desc = "Config",
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          {
            icon = "󰚰 ",
            key = "u",
            desc = "Lazy Update",
            action = ":Lazy! sync",
            enabled = package.loaded.lazy ~= nil,
          },
          { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { icon = "󰗼 ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
      sections = {
        {
          section = "terminal",
          cmd = "lolcat --seed=24 ~/.config/nvim/static/azvim.cat",
          indent = 8,
          height = 10,
          padding = { 2, 2 },
        },
        { section = "keys", gap = 1, padding = 2 },
        { icon = " ", title = "Recent Files", section = "recent_files", padding = { 1, 1 } },
        { icon = " ", title = "Projects", section = "projects", padding = { 1, 1 } },
        {
          icon = " ",
          title = "Git Status",
          section = "terminal",
          enabled = vim.fn.isdirectory(".git") == 1,
          cmd = "git --no-pager diff --stat -B -M -C",
          height = 10,
          padding = 1,
        },
        { section = "startup" },
      },
    },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = true },
    picker = {
      enabled = true,
      layout = {
        preset = "ivy",
      },
      win = {
        -- input window
        input = {
          keys = {
            ["<c-u>"] = false,
          },
        },
      },
    },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
  }
end

function M.keys()
  return {
    {
      "<leader>ff",
      function()
        require("snacks").picker.smart({
          multi = {
            "buffers",
            "recent",
            {
              source = "files",
              hidden = true,
            },
          },
          filter = {
            cwd = true,
          },
        })
      end,
      desc = "[F]ind [F]iles",
    },
    {
      "<leader>fb",
      function()
        require("snacks").picker.buffers()
      end,
      desc = "[F]ind [B]uffers",
    },
    {
      "<leader>fd",
      function()
        require("snacks").picker.diagnostics()
      end,
      desc = "[F]ind [D]iagnostics",
    },
    {
      "<leader>fh",
      function()
        require("snacks").picker.help()
      end,
      desc = "[F]ind [H]elp",
    },
    {
      "<leader>fk",
      function()
        require("snacks").picker.keymaps()
      end,
      desc = "[F]ind [K]eymaps",
    },
    {
      "<leader>fn",
      function()
        require("snacks").picker.notifications()
      end,
      desc = "[F]ind [N]otifications",
    },
    {
      "<leader>fr",
      function()
        require("snacks").picker.recent()
      end,
      desc = "[F]ind [R]ecent",
    },
    {
      "<leader>fs",
      function()
        require("snacks").picker.lsp_symbols()
      end,
      desc = "[F]ind [S]ymbols",
    },
    {
      "<leader>fw",
      function()
        require("snacks").picker.grep_word()
      end,
      desc = "[F]ind [W]ord or visual selection",
      mode = { "n", "x" },
    },
    {
      "<leader>ft",
      function()
        require("snacks").picker.grep({ hidden = true })
      end,
      desc = "[F]ind [T]ext",
    },
    {
      "gd",
      function()
        require("snacks").picker.lsp_definitions()
      end,
      desc = "[G]o to [D]efinition",
    },
    {
      "gD",
      function()
        require("snacks").picker.lsp_declarations()
      end,
      desc = "[G]oto [D]eclaration",
    },

    {
      "gr",
      function()
        require("snacks").picker.lsp_references()
      end,
      desc = "References",
    },
    {
      "gI",
      function()
        require("snacks").picker.lsp_implementations()
      end,
      desc = "[G]o to [I]mplementation",
    },
    {
      "gt",
      function()
        require("snacks").picker.lsp_type_definitions()
      end,
      desc = "Goto [T]ype Definition",
    },
    {
      "<leader>ls",
      function()
        require("snacks").picker.lsp_symbols()
      end,
      desc = "[L]SP Document [S]ymbols",
    },
    {
      "<leader>lw",
      function()
        require("snacks").picker.lsp_workspace_symbols()
      end,
      desc = "[L]SP [W]orkspace Symbols",
    },
  }
end

return M
