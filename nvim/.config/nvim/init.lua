local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- required to before lazy so mappings are correct
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

opt.backup = false -- creates a backup file
opt.background = "dark" -- default themes to dark
opt.clipboard = "" -- explicitly copy to the clipboard to keep control of what gets copied there.
opt.cmdheight = 1 -- more space in the neovim command line for displaying messages
opt.completeopt = { "menu", "menuone", "noselect" } -- mostly just for cmp
opt.conceallevel = 0 -- so that `` is visible in markdown files
opt.equalalways = true -- make windows the samue width when closing one
opt.fileencoding = "utf-8" -- the encoding written to a file
opt.hlsearch = true -- highlight all matches on previous search pattern
opt.ignorecase = true -- ignore case in search patterns
opt.mouse = "a" -- allow the mouse to be used in neovim
opt.pumheight = 10 -- pop up menu height
opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
opt.showtabline = 0 -- always show tabs
opt.smartcase = true -- smart case
opt.smartindent = true -- make indenting smarter again
opt.splitbelow = true -- force all horizontal splits to go below current window
opt.splitright = true -- force all vertical splits to go to the right of current window
opt.swapfile = false -- creates a swapfile
opt.termguicolors = true -- set term gui colors (most terminals support this)
opt.timeoutlen = 1000 -- time to wait for a mapped sequence to complete (in milliseconds).
opt.undofile = true -- enable persistent undo
opt.updatetime = 300 -- faster completion (4000ms default)
opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
opt.expandtab = true -- convert tabs to spaces
opt.shiftwidth = 2 -- the number of spaces inserted for each indentation
opt.tabstop = 2 -- insert 2 spaces for a tab
opt.cursorline = true -- highlight the current line
opt.laststatus = 3
opt.showcmd = false
opt.ruler = false
opt.number = true -- set numbered lines
opt.relativenumber = true -- set relative numbered lines
opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
opt.wrap = false -- display lines as one long line
opt.guifont = "monospace:h17" -- the font used in graphical neovim applications

-- netrw
-- vim.g.netrw_banner = 0
-- vim.g.netrw_winsize = 25

-- fugitive
vim.g.fugitive_gitlab_domains = { "https://git.tmaws.io" }

-- Fixes Autocomment
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	callback = function()
		vim.cmd("set formatoptions-=cro")
	end,
})

-- Highlight yanks
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
	end,
})

local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

-- Stolen from theprimeagen
-- @see https://github.com/ThePrimeagen/init.lua/blob/master/lua/theprimeagen/remap.lua
-- @see https://www.youtube.com/watch?v=w7i4amO_zaE
-- Move selected line / block of text in visual mode
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)
-- Stop cursor jumping to the end of the line when joining lines with J
keymap("n", "J", "mzJ`z", opts)
-- Less jarring paging
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "<C-d>", "<C-d>zz", opts)
-- Keep cursor centered when going through search matches
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- Resize with arrows
keymap("n", "<A-Up>", ":resize -2<CR>", opts)
keymap("n", "<A-Down>", ":resize +2<CR>", opts)
keymap("n", "<A-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<A-Right>", ":vertical resize +2<CR>", opts)

-- Leader mappings
keymap("n", "<Leader><Leader>", "<cmd>noh<CR>", opts)

-- Better paste that doesn't lose what was in the paste register when we want to replace the selected text.
-- We delete to the Black Hole register ("_") so our paste register will keep the text we copied.
-- @see https://youtu.be/qZO9A5F6BZs?t=352
keymap("x", "<Leader>p", '"_dP', opts)

-- Better delete
keymap("n", "<Leader>d", '"_d', opts)
keymap("v", "<Leader>d", '"_d', opts)

--- Easier saving
keymap("n", "<Leader>w", vim.cmd.write, opts)

-- Easier quitting
keymap("n", "<Leader>q", vim.cmd.quit, opts)

--- copy to system clipboard
keymap("n", "<Leader>y", '"+y', opts)
keymap("n", "<Leader>Y", '"+Y', opts)
keymap("v", "<Leader>y", '"+y', opts)

require("lazy").setup('plugins')
