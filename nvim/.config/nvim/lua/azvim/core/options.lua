-- required to before lazy so mappings are correct
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.background = "dark" -- default themes to dark
vim.opt.backup = false -- don't create a backup file
vim.opt.clipboard = "" -- explicitly copy to the clipboard to keep control of what gets copied there.
vim.opt.cmdheight = 1 -- more space in the neovim command line for displaying messages
-- see https://github.com/epwalsh/obsidian.nvim?tab=readme-ov-file#concealing-characters
vim.opt.conceallevel = 2 -- for obsidian.nvim to concel characters.
vim.opt.cursorline = true -- highlight the current line
vim.opt.equalalways = true -- make windows the samue width when closing one
vim.opt.fileencoding = "utf-8" -- the encoding written to a file
vim.opt.guifont = "monospace:h17" -- the font used in graphical neovim applications
vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.laststatus = 3
vim.opt.mouse = "a" -- allow the mouse to be used in neovim
vim.opt.pumheight = 10 -- pop up menu height
vim.opt.ruler = false
vim.opt.showcmd = false
vim.opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
vim.opt.showtabline = 0 -- always show tabs
vim.opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
vim.opt.smartcase = true -- smart case
vim.opt.smartindent = true -- make indenting smarter again
vim.opt.swapfile = false -- creates a swapfile
vim.opt.termguicolors = true -- set term gui colors (most terminals support this)
vim.opt.wrap = false -- display lines as one long line
vim.opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited

-- convert tabs to spaces
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.tabstop = 2 -- insert 2 spaces for a tab
vim.opt.shiftwidth = 2 -- the number of spaces inserted for each indentation

-- line numbers
vim.opt.number = true -- set numbered lines
vim.opt.relativenumber = true -- set relative numbered lines

-- save undo history
vim.opt.undodir = os.getenv("HOME") .. "/.config/nvim/undodir" -- set an undo directory
vim.opt.undofile = true -- enable persistent undo

-- splits
vim.opt.splitbelow = true -- force all horizontal splits to go below current window
vim.opt.splitright = true -- force all vertical splits to go to the right of current window

-- decrease update time
vim.opt.updatetime = 250 -- faster completion (4000ms default)
vim.opt.timeoutlen = 300 -- time to wait for a mapped sequence to complete (in milliseconds).

-- Sets how neovim will display certain whitespace in the editor.
--  See :help 'list'
--  and :help 'listchars'
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
