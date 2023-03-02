return {
	"rgroli/other.nvim",
	event = "BufReadPost",
	config = function()
		require("other-nvim").setup({
			rememberBuffers = false,
			mappings = {
				{
					pattern = "/(.*)/(.*).ts(.*)$",
					target = {
						{
							target = "/%1/%2.test.ts%3",
							context = "test",
						},
						{
							target = "/%1/%2.stories.ts",
							context = "story",
						},
					},
				},
				{
					pattern = "/(.*)/(.*).test.ts(.*)$",
					target = {
						{
							target = "/%1/%2.ts%3",
							context = "implementation",
						},
						{
							target = "/%1/%2.stories.ts",
							context = "story",
						},
					},
				},
				{
					pattern = "/(.*)/(.*).stories.ts$",
					target = {
						{
							target = "/%1/%2.tsx",
							context = "implementation",
						},
						{
							target = "/%1/%2.test.tsx",
							context = "test",
						},
					},
				},
			},
		})
	end,
	keys = {
		{ "<leader>kk", "<cmd>Other<CR>", desc = "Open related file" },
		{ "<leader>kv", "<cmd>OtherVSplit<CR>", desc = "Open related file in split" },
		{ "<leader>kt", "<cmd>OtherVSplit test<CR>", desc = "Open test" },
		{ "<leader>ks", "<cmd>OtherVSplit story<CR>", desc = "Open story" },
		{ "<leader>ki", "<cmd>OtherVSplit implementation<CR>", desc = "Open implementation" },
		{ "<leader>kc", "<cmd>OtherClear<CR>", desc = "Clear related files" },
	},
}
