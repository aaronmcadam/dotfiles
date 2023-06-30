return {
  -- commenting
  { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    opts = {
      options = {
        custom_commentstring = function()
          return require("ts_context_commentstring.internal").calculate_commentstring()
            or vim.bo.commentstring
        end,
      },
    },
  },

  -- lsp
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = require("azvim.plugins.configs.lspconfig").setup,
    dependencies = {
      "williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			{ "j-hui/fidget.nvim", tag = "legacy" },
			"folke/neodev.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
  },

  -- diagnostics and formatting
  {
		"jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"nvim-lua/plenary.nvim",
			"jayp0521/mason-null-ls.nvim",
		},
		-- build = "npm install -g @prettier/plugin-ruby prettier-plugin-erb",
    config = require("azvim.plugins.configs.null-ls").setup,
  }
}
