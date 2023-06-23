return {
	-- which-key
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			plugins = { spelling = true },
			defaults = {
				mode = { "n", "v" },
				["g"] = { name = "+goto" },
				["<leader>b"] = { name = "+buffer" },
				-- ["<leader>f"] = { name = "+file/find" },
				["<leader>g"] = { name = "+git" },
				-- ["<leader>k"] = { name = "+related" },
				-- ["<leader>l"] = { name = "+lsp" },
				["<leader>q"] = { name = "+quit" },
				-- ["<leader>w"] = { name = "save" },
				-- ["<leader>t"] = { name = "+test" },
				-- ["<leader>x"] = { name = "+diagnostics/quickfix" },
			},
		},
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)
			wk.register(opts.defaults)
		end,
	},
}
