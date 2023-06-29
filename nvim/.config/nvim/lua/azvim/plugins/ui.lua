local telescope_helpers = require("azvim.helpers.telescope")

return {
	-- Fancier statusline
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			local lualine_theme = "catppuccin"
			require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = lualine_theme,
					component_separators = "|",
					section_separators = "",
				},
			})
		end,
	},
	-- Show buffer names
	{
		"akinsho/bufferline.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({
				options = {
					-- NOTE: this will be called a lot so don't do any heavy processing here
					custom_filter = function(buf_number, _buf_numbers)
						-- filter out filetypes you don't want to see
						if vim.bo[buf_number].filetype ~= "oil" then
							return true
						end
					end,
				},
			})
		end,
	},
	-- harpoon
	{
		"ThePrimeagen/harpoon",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{
				"<leader>ha",
				function()
					require("harpoon.mark").add_file()
				end,
				desc = "Add Harpoon mark",
			},
			{
				"<leader>hh",
				function()
					require("harpoon.ui").toggle_quick_menu()
				end,
				desc = "View Harpoon marks",
			},
		},
		config = function()
			require("harpoon").setup()
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"echasnovski/mini.fuzzy",
				config = function()
					require("mini.fuzzy").setup()
				end,
			},
		},
		cmd = "Telescope",
		keys = {
			{ "<leader>ff", telescope_helpers.project_files, desc = "Find Files" },
			{ "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<CR>", desc = "Find Buffers" },
			{ "<leader>fh", "<cmd>Telescope harpoon marks<CR>", desc = "Find Harpoon Marks" },
			{ "<leader>ft", "<cmd>lua require('telescope.builtin').live_grep()<CR>", desc = "Find Text" },
			{
				"<leader>fw",
				"<cmd>lua require('telescope.builtin').grep_string()<CR>",
				desc = "Find Word Under Cursor",
			},
			{ "gs", "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>", desc = "Jump to definition" },
			{
				"gv",
				"<cmd>lua require('telescope.builtin').lsp_definitions({ jump_type='vsplit' })<CR>",
				desc = "Jump to definition in vsplit",
			},
		},
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			local sorter = require("mini.fuzzy").get_telescope_sorter

			telescope.setup({
				defaults = {
					mappings = {
						i = {
							["<C-k>"] = actions.move_selection_previous, -- move to prev result
							["<C-j>"] = actions.move_selection_next, -- move to next result
						},
					},
					file_sorter = sorter,
					generic_sorter = sorter,
				},
				pickers = {
					find_files = {
						theme = "dropdown",
					},
					git_files = {
						theme = "dropdown",
					},
					live_grep = {
						additional_args = function()
							-- Dotfiles are getting hidden because they're technically hidden files.
							-- If we set ripgrep to include hidden files, we see too many files that we don't care about.
							-- But ripgrep doesn't seem to support searching hidden files that are tracked by git.
							-- We can filter out git repos though.
							return { "--hidden", "-g", "!.git" }
						end,
					},
				},
			})

			-- telescope.load_extension("harpoon")
		end,
	},
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		opts = function()
			local dashboard = require("alpha.themes.dashboard")
			local logo = [[
 █████╗ ███████╗██╗   ██╗██╗███╗   ███╗
██╔══██╗╚══███╔╝██║   ██║██║████╗ ████║
███████║  ███╔╝ ██║   ██║██║██╔████╔██║
██╔══██║ ███╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║
██║  ██║███████╗ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═╝╚══════╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
      ]]
			dashboard.section.header.val = vim.split(logo, "\n")
			dashboard.section.buttons.val = {
				dashboard.button(
					"f",
					" " .. " Find file",
					":lua require('azvim.helpers.telescope').project_files()<CR>"
				),
				dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert<CR>"),
				dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles<CR>"),
				dashboard.button("t", " " .. " Find text", ":Telescope live_grep<CR>"),
				dashboard.button("c", " " .. " Config", ":e $MYVIMRC<CR>"),
				dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
				dashboard.button("q", " " .. " Quit", ":qa<CR>"),
			}
			for _, button in ipairs(dashboard.section.buttons.val) do
				button.opts.hl = "AlphaButtons"
				button.opts.hl_shortcut = "AlphaShortcut"
			end
			dashboard.section.header.opts.hl = "AlphaHeader"
			dashboard.section.buttons.opts.hl = "AlphaButtons"
			dashboard.section.footer.opts.hl = "AlphaFooter"
			dashboard.opts.layout[1].val = 8
			return dashboard
		end,
		config = function(_, dashboard)
			-- close Lazy and re-open when the dashboard is ready
			if vim.o.filetype == "lazy" then
				vim.cmd.close()
				vim.api.nvim_create_autocmd("User", {
					pattern = "AlphaReady",
					callback = function()
						require("lazy").show()
					end,
				})
			end

			require("alpha").setup(dashboard.opts)

			vim.api.nvim_create_autocmd("User", {
				pattern = "LazyVimStarted",
				callback = function()
					local stats = require("lazy").stats()
					local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
					dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
					pcall(vim.cmd.AlphaRedraw)
				end,
			})
		end,
	},
	-- Better `vim.notify()`
	{
		"rcarriga/nvim-notify",
		keys = {
			{
				"<leader>un",
				function()
					require("notify").dismiss({ silent = true, pending = true })
				end,
				desc = "Dismiss all Notifications",
			},
		},
		opts = {
			timeout = 3000,
			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.75)
			end,
		},
		init = function()
			vim.notify = require("notify")
		end,
	},
}
