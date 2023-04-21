vim.g["test#strategy"] = "neovim"
vim.g["test#runner_commands"] = { "Jest", "Playwright" }

-- Map Esc to Normal mode in terminal buffers
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true })

return {
	{
		"vim-test/vim-test",
		dependencies = {
			-- This plugin is important to set the project root when working within a monorepo for vim-test to find jest and playwright.
			-- It doesn't seem to work properly if I lazy load it, so I've turned off lazy loading for it for now.
			"ahmedkhalf/project.nvim",
		},
		lazy = false,
		config = function()
			require("project_nvim").setup()
		end,
		keys = {
			{ "<leader>tt", "<cmd>w<CR><cmd>TestNearest<CR>", desc = "Test Nearest" },
			{ "<leader>tf", "<cmd>w<CR><cmd>TestFile<CR>", desc = "Test File" },
			{ "<leader>tl", "<cmd>w<CR><cmd>TestLast<CR>", desc = "Test Last" },
			{ "<leader>ts", "<cmd>w<CR><cmd>TestSuite<CR>", desc = "Test Suite" },
			{ "<leader>tv", "<cmd>w<CR><cmd>TestVisit<CR>", desc = "Test Visit" },
			{ "<leader>tp", "<cmd>w<CR><cmd>Playwright --project=chromium<CR>", desc = "Playwright" },
			{ "<leader>th", "<cmd>w<CR><cmd>Playwright --project=chromium --headed<CR>", desc = "Playwright Headed" },
			{ "<leader>td", "<cmd>w<CR><cmd>Playwright --project=chromium --debug<CR>", desc = "Playwright Debug" },
		},
	},
}