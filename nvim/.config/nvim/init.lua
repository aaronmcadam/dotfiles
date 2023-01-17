require("user.plugins.install-plugins")
require("user.core.options")
require("user.core.keymaps")
require("user.core.colorscheme")
require("user.core.autocommands")

-- plugin config
require("user.plugins.configs.alpha")
require("user.plugins.configs.colorizer")
require("user.plugins.configs.comment")
require("user.plugins.configs.gitsigns")
require("user.plugins.configs.impatient")
require("user.plugins.configs.lualine")
require("user.plugins.configs.navic")
require("user.plugins.configs.dap")
require("user.plugins.configs.neotest")
require("user.plugins.configs.nvim-notify")
require("user.plugins.configs.other")
require("user.plugins.configs.surround")
require("user.plugins.configs.telescope")
require("user.plugins.configs.toggleterm")

-- LSP
require("user.plugins.configs.lsp.mason")
require("user.plugins.configs.lsp.lspsaga")
require("user.plugins.configs.lsp.lspconfig")
require("user.plugins.configs.lsp.null-ls")

-- Plugins that may depend upon LSP
require("user.plugins.configs.nvim-cmp")
-- Disable autopairs for now because when completing with Copilot, I get the extra closing symbol.
-- require("user.plugins.configs.autopairs")
require("user.plugins.configs.treesitter")
