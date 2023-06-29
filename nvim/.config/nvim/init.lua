-- Core options
require("azvim.core.options")

-- Handle plugins with lazy.nvim
require("azvim.core.lazy")

-- General Neovim keymaps
require("azvim.core.keymaps")

-- Auto commands
require("azvim.core.autocmds")

-- Set color scheme after all plugins have loaded
require("azvim.core.colorscheme")
