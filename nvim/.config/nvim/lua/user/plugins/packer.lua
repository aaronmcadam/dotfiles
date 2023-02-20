-- auto install packer if not installed
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[ 
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer.lua source <afile> | PackerSync
  augroup end
]])

local status, packer = pcall(require, "packer")
if not status then
	return
end

-- Use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

return packer.startup(function(use)
	use("wbthomason/packer.nvim") -- Have packer manage itself
	use("lewis6991/impatient.nvim") -- Speed up loading Lua modules
	use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
	use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins
	use("numToStr/Comment.nvim") -- Commenting
	use("JoosepAlviste/nvim-ts-context-commentstring") -- TSX support for commenting
	use("kyazdani42/nvim-web-devicons") -- Icons
	use("kylechui/nvim-surround") -- Surround text objects
	use("antoinemadec/FixCursorHold.nvim") -- This is needed to fix lsp doc highlight
	use("goolord/alpha-nvim") -- Dashboard
	use("nvim-lualine/lualine.nvim") -- Status line
	use("SmiteshP/nvim-navic") -- code navigation
	use("brenoprata10/nvim-highlight-colors") -- highlight colours
	use("rgroli/other.nvim") -- Open related files in another buffer
	use("ThePrimeagen/harpoon") -- mark files to navigate between
	use("rcarriga/nvim-notify") -- notification manager
	use("mbbill/undotree") -- undo history
	use("tpope/vim-vinegar") -- better netrw
	use("RRethy/vim-illuminate") -- highlight other uses of the word under the cursor

	-- Colorschemes
	use({ "catppuccin/nvim", as = "catppuccin" })

	-- Completion
	use("hrsh7th/nvim-cmp") -- The completion plugin
	use("hrsh7th/cmp-buffer") -- buffer completions
	use("hrsh7th/cmp-path") -- path completions

	-- Snippets
	use({
		"L3MON4D3/LuaSnip",
		run = "make install_jsregexp",
	})
	use("saadparwaiz1/cmp_luasnip") -- for autocompletion

	-- managing & installing lsp servers, linters & formatters
	use("williamboman/mason.nvim") -- in charge of managing lsp servers, linters & formatters
	use("williamboman/mason-lspconfig.nvim") -- bridges gap b/w mason & lspconfig

	-- configuring lsp servers
	use("neovim/nvim-lspconfig") -- configure LSP
	use("hrsh7th/cmp-nvim-lsp") -- for autocompletion
	use("glepnir/lspsaga.nvim") -- shows a popup for things like code actions
	use("jose-elias-alvarez/typescript.nvim") -- for TypeScript LSP commands
	use("onsails/lspkind.nvim") -- icons for autocompletion
	use({
		"zbirenbaum/copilot.lua",
		event = "VimEnter",
		config = function()
			vim.defer_fn(function()
				require("copilot").setup()
			end, 100)
		end,
	}) -- GitHub Copilot
	use({
		"zbirenbaum/copilot-cmp",
		after = { "copilot.lua" },
		config = function()
			require("copilot_cmp").setup()
		end,
	})

	-- formatting and linting
	use("jose-elias-alvarez/null-ls.nvim") -- configure formatters & linters
	use("jayp0521/mason-null-ls.nvim") -- bridges gap b/w mason & null-ls

	-- Telescope
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- better sorting performance
	use("nvim-telescope/telescope.nvim") -- fuzzy finder

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})

	-- auto closing
	use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- autoclose tags

	-- Git
	use("akinsho/toggleterm.nvim") -- Manage terminal windows
	use("lewis6991/gitsigns.nvim") -- Git integration for buffers
	use("tpope/vim-fugitive") -- Git wrapper
	use("shumphrey/fugitive-gitlab.vim") -- support GitLab in fugitive

	-- Testing
	use("vim-test/vim-test")
	use({
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup()
		end,
	})

	-- debugging
	use("mfussenegger/nvim-dap") -- debugger
	use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
	use({ "mxsdev/nvim-dap-vscode-js", requires = { "mfussenegger/nvim-dap" } })

	if packer_bootstrap then
		require("packer").sync()
	end
end)
