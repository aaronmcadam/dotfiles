require "user.plugins-setup"
require "user.core.options"
require "user.core.keymaps"
require "user.core.colorscheme"
require "user.core.autocommands"

-- plugin config
require "user.plugins.alpha"
require "user.plugins.colorizer"
require "user.plugins.comment"
require "user.plugins.gitsigns"
require "user.plugins.impatient"
require "user.plugins.lualine"
require "user.plugins.navic"
require "user.plugins.neotest"
require "user.plugins.other"
require "user.plugins.surround"
require "user.plugins.telescope"
require "user.plugins.toggleterm"

-- LSP
require "user.plugins.lsp.mason"
require "user.plugins.lsp.lspsaga"
require "user.plugins.lsp.lspconfig"
require "user.plugins.lsp.null-ls"

-- Plugins that may depend upon LSP
require "user.plugins.nvim-cmp"
require "user.plugins.autopairs"
require "user.plugins.treesitter"
