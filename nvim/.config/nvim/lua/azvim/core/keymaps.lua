local map = require("azvim.helpers.keys").map

-- Stolen from theprimeagen
-- @see https://github.com/ThePrimeagen/init.lua/blob/master/lua/theprimeagen/remap.lua
-- @see https://www.youtube.com/watch?v=w7i4amO_zaE
-- Move selected line / block of text in visual mode
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
-- Stop cursor jumping to the end of the line when joining lines with J
map("n", "J", "mzJ`z")
-- Less jarring paging
map("n", "<C-u>", "<C-u>zz")
map("n", "<C-d>", "<C-d>zz")
-- Keep cursor centered when going through search matches
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Better paste that doesn't lose what was in the paste register when we want to replace the selected text.
-- We delete to the Black Hole register ("_") so our paste register will keep the text we copied.
-- @see https://youtu.be/qZO9A5F6BZs?t=352
map("x", "<Leader>p", '"_dP', { desc = "Better Paste" })

--- copy to system clipboard
map("n", "<Leader>y", '"+y', { desc = "Copy to system clipboard" })
map("n", "<Leader>Y", '"+Y', { desc = "Copy to system clipboard" })
map("v", "<Leader>y", '"+y', { desc = "Copy to system clipboard" })

-- buffers
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- save file
map("n", "<leader>w", "<cmd>w<cr><esc>", { desc = "Save file" })

-- quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })
