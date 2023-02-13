local status_ok, other = pcall(require, "other-nvim")
if not status_ok then
	return
end

other.setup({
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
