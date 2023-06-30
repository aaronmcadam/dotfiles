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

	-- snippets
	{
		"L3MON4D3/LuaSnip",
		build = "make install_jsregexp",
		config = function()
			require("luasnip").setup({
				history = true,
				delete_check_events = "TextChanged",
			})
			require("luasnip/loaders/from_vscode").load({
				paths = vim.fn.stdpath("config") .. "/lua/azvim/snippets",
			})
		end,
		keys = {
			{
				"<C-y>",
				function()
					return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<C-y>"
				end,
				expr = true,
				silent = true,
				mode = "i",
			},
			{
				"<C-y>",
				function()
					require("luasnip").jump(1)
				end,
				mode = "s",
			},
			{
				"<M-y>",
				function()
					require("luasnip").jump(-1)
				end,
				mode = { "i", "s" },
			},
		},
	},

	-- copilot
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		build = ":Copilot auth",
		opts = {
			suggestion = { enabled = false },
			panel = { enabled = false },
		},
	},

	-- completion
	{
		"hrsh7th/nvim-cmp",
		version = false, -- last release is way too old
		event = "BufReadPre",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			{
				"L3MON4D3/LuaSnip",
				build = "make install_jsregexp",
			},
			"saadparwaiz1/cmp_luasnip",
			{
				"zbirenbaum/copilot-cmp",
				dependencies = "zbirenbaum/copilot.lua",
				config = function()
					require("copilot_cmp").setup()
				end,
			},
		},
		opts = function()
			local cmp = require("cmp")
			local behaviour = cmp.SelectBehavior.Insert
			local has_words_before = function()
				if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
					return false
				end
				local line, col = vim.F.unpack_len(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end
			local luasnip = require("luasnip")

			return {
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item({ behavior = behaviour })
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end),
					["<C-p>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item({ behavior = behaviour })
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end),
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<C-y>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
					["<M-y>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = cmp.config.sources({
					{ name = "luasnip", priority = 1000 },
					{ name = "nvim_lsp", priority = 800 },
					{ name = "copilot", priority = 700 },
					{ name = "buffer", priority = 500 },
					{ name = "path", priority = 250 },
				}),
			}
		end,
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
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"jose-elias-alvarez/null-ls.nvim",
		},
		build = "npm install -g @prettier/plugin-ruby prettier-plugin-erb",
		config = require("azvim.plugins.configs.null-ls").setup,
	},
}
