return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/nvim-cmp", -- The completion plugin
		"hrsh7th/cmp-buffer", -- buffer completions
		"hrsh7th/cmp-path", -- path completions
		{
			"L3MON4D3/LuaSnip",
			build = "make install_jsregexp",
		},
		"saadparwaiz1/cmp_luasnip",
		"onsails/lspkind.nvim",
		{
			"zbirenbaum/copilot.lua",
			dependencies = {
				"zbirenbaum/copilot-cmp",
			},
		},
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local lspkind = require("lspkind")

		require("luasnip/loaders/from_vscode").load({
			paths = vim.fn.stdpath("config") .. "/snippets",
		})

		require("copilot").setup()
		require("copilot_cmp").setup()

		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-d>"] = cmp.mapping.scroll_docs(-4),
				["<C-u>"] = cmp.mapping.scroll_docs(4),
				["<C-e>"] = cmp.mapping.abort(), -- close completion window
				["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
				["<C-y>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Replace,
					select = true,
				}),
				["<C-n>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, { "i", "s" }),
				["C-p"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			}),
			-- sources for autocompletion
			sources = cmp.config.sources({
				{ name = "nvim_lsp", priority = 1000 },
				{ name = "copilot", priority = 800 },
				{ name = "luasnip", priority = 700 },
				{ name = "buffer", priority = 500 },
				{ name = "path", priority = 250 },
			}),
			formatting = {
				format = lspkind.cmp_format({
					maxwidth = 50,
					ellipsis_char = "...",
					symbol_map = { Copilot = "" },
				}),
			},
		})
	end,
}
