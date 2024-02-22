-- required to before lazy so mappings are correct
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

opt.background = "dark" -- default themes to dark
opt.backup = false -- creates a backup file
opt.clipboard = "" -- explicitly copy to the clipboard to keep control of what gets copied there.
opt.cmdheight = 1 -- more space in the neovim command line for displaying messages
opt.completeopt = { "menu", "menuone", "noselect" } -- mostly just for cmp
-- see https://github.com/epwalsh/obsidian.nvim?tab=readme-ov-file#concealing-characters
opt.conceallevel = 2 -- for obsidian.nvim to concel characters.
opt.cursorline = true -- highlight the current line
opt.equalalways = true -- make windows the samue width when closing one
opt.expandtab = true -- convert tabs to spaces
opt.fileencoding = "utf-8" -- the encoding written to a file
opt.guifont = "monospace:h17" -- the font used in graphical neovim applications
opt.hlsearch = true -- highlight all matches on previous search pattern
opt.ignorecase = true -- ignore case in search patterns
opt.laststatus = 3
opt.mouse = "a" -- allow the mouse to be used in neovim
opt.number = true -- set numbered lines
opt.pumheight = 10 -- pop up menu height
opt.relativenumber = true -- set relative numbered lines
opt.ruler = false
-- TODO: test if the binaries get added to the PATH with this setting.
-- opt.shell = "/bin/sh" -- Fish can be slow with neovim: https://github.com/fish-shell/fish-shell/issues/7004
opt.shiftwidth = 2 -- the number of spaces inserted for each indentation
opt.showcmd = false
opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
opt.showtabline = 0 -- always show tabs
opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
opt.smartcase = true -- smart case
opt.smartindent = true -- make indenting smarter again
opt.splitbelow = true -- force all horizontal splits to go below current window
opt.splitright = true -- force all vertical splits to go to the right of current window
opt.swapfile = false -- creates a swapfile
opt.tabstop = 2 -- insert 2 spaces for a tab
opt.termguicolors = true -- set term gui colors (most terminals support this)
opt.timeoutlen = 1000 -- time to wait for a mapped sequence to complete (in milliseconds).
opt.undodir = os.getenv("HOME") .. "/.config/nvim/undodir" -- set an undo directory
opt.undofile = true -- enable persistent undo
opt.updatetime = 300 -- faster completion (4000ms default)
opt.wrap = false -- display lines as one long line
opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
