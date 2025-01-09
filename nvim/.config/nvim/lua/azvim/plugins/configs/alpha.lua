local M = {}

local function header_color()
  local colors = require("catppuccin.palettes").get_palette("mocha")
  vim.api.nvim_set_hl(0, "AlphaCustom", { fg = colors.sapphire })

  return "AlphaCustom"
end

function M.opts()
  local dashboard = require("alpha.themes.dashboard")

  local logo = [[
    ______           __     __ __
   /      \         |  \   |  \  \
  |  ▓▓▓▓▓▓\________| ▓▓   | ▓▓\▓▓______ ____
  | ▓▓__| ▓▓        \ ▓▓   | ▓▓  \      \    \
  | ▓▓    ▓▓\▓▓▓▓▓▓▓▓\▓▓\ /  ▓▓ ▓▓ ▓▓▓▓▓▓\▓▓▓▓\
  | ▓▓▓▓▓▓▓▓ /    ▓▓  \▓▓\  ▓▓| ▓▓ ▓▓ | ▓▓ | ▓▓
  | ▓▓  | ▓▓/  ▓▓▓▓_   \▓▓ ▓▓ | ▓▓ ▓▓ | ▓▓ | ▓▓
  | ▓▓  | ▓▓  ▓▓    \   \▓▓▓  | ▓▓ ▓▓ | ▓▓ | ▓▓
   \▓▓   \▓▓\▓▓▓▓▓▓▓▓    \▓    \▓▓\▓▓  \▓▓  \▓▓
  ]]
  dashboard.section.header.val = vim.split(logo, "\n")
  dashboard.section.buttons.val = {
    dashboard.button(
      "f",
      " " .. " Find file",
      "<cmd>lua require('telescope').extensions.smart_open.smart_open()<CR>"
    ),
    dashboard.button("n", " " .. " New file", "<cmd>ene <BAR> startinsert<CR>"),
    dashboard.button("t", " " .. " Find text", "<cmd>lua require('telescope.builtin').live_grep()<CR>"),
    dashboard.button(
      "w",
      "" .. "  Open worktree",
      "<cmd>lua require('telescope').extensions.git_worktree.git_worktree()<CR>"
    ),
    dashboard.button(
      "c",
      " " .. " Config",
      "<cmd>lua require('telescope.builtin').find_files({ cwd = vim.fn.stdpath('config') })<CR>"
    ),
    dashboard.button("u", "󰚰 " .. " Update plugins", "<cmd>Lazy! sync<CR>"),
    dashboard.button("p", " " .. " View plugins", "<cmd>Lazy<CR>"),
    dashboard.button("q", " " .. " Quit", "<cmd>qa<CR>"),
  }

  for _, button in ipairs(dashboard.section.buttons.val) do
    button.opts.hl = "AlphaButtons"
    button.opts.hl_shortcut = "AlphaShortcut"
  end

  dashboard.section.header.opts.hl = header_color()
  dashboard.section.buttons.opts.hl = "AlphaButtons"
  dashboard.section.footer.opts.hl = "AlphaFooter"
  dashboard.opts.layout[1].val = 8

  return dashboard
end

function M.setup(_, dashboard)
  -- close Lazy and re-open when the dashboard is ready
  if vim.o.filetype == "lazy" then
    vim.cmd.close()
    vim.api.nvim_create_autocmd("User", {
      pattern = "AlphaReady",
      callback = function()
        require("lazy").show()
      end,
    })
  end

  require("alpha").setup(dashboard.opts)

  vim.api.nvim_create_autocmd("User", {
    pattern = "LazyVimStarted",
    callback = function()
      local stats = require("lazy").stats()
      local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
      dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
      pcall(vim.cmd.AlphaRedraw)
    end,
  })
end

return M
