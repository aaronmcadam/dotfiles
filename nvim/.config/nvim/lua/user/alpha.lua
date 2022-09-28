local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = {
  [[                                                                   ]],
  [[      ████ ██████           █████      ██                    ]],
  [[     ███████████             █████                            ]],
  [[     █████████ ███████████████████ ███   ███████████  ]],
  [[    █████████  ███    █████████████ █████ ██████████████  ]],
  [[   █████████ ██████████ █████████ █████ █████ ████ █████  ]],
  [[ ███████████ ███    ███ █████████ █████ █████ ████ █████ ]],
  [[██████  █████████████████████ ████ █████ █████ ████ ██████]],
}

dashboard.section.buttons.val = {
  dashboard.button("f", " " .. " Find file", "<cmd>lua require('user.telescope').project_files()<CR>"),
  dashboard.button("e", " " .. " New file", ":ene <BAR> startinsert<CR>"),
  dashboard.button("p", " " .. " Find project", "<cmd>Telescope projects<CR>"),
  dashboard.button("r", " " .. " Recent files", "<cmd>Telescope oldfiles<CR>"),
  dashboard.button("t", " " .. " Find text", "<cmd>Telescope live_grep<CR>"),
  dashboard.button("c", " " .. " Config", ":e ~/.config/nvim/init.lua<CR>"),
  dashboard.button("u", " " .. " Update plugins", "<cmd>PackerSync<CR>"),
  dashboard.button("q", " " .. " Quit", ":qa<CR>"),
}

dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

alpha.setup(dashboard.opts)
