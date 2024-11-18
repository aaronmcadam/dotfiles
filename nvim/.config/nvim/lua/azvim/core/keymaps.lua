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

-- Keep cursor centered when going through quickfix items
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")

-- Better paste that doesn't lose what was in the paste register when we want to replace the selected text.
-- We delete to the Black Hole register ("_") so our paste register will keep the text we copied.
-- @see https://youtu.be/qZO9A5F6BZs?t=352
map("x", "<Leader>p", '"_dP', "Paste")

--- copy to system clipboard
map("n", "<Leader>y", '"+y', "Copy to system clipboard")
map("n", "<Leader>Y", '"+Y', "Copy to system clipboard")
map("v", "<Leader>y", '"+y', "Copy to system clipboard")

-- buffers
map("n", "<leader>bb", "<cmd>e #<cr>", "Switch to Other Buffer")

-- save file and quit
map("n", "<leader>s", "<cmd>update<cr>", "Save file")
map("n", "<leader>qq", "<cmd>quit<cr>", "Quit")
map("n", "<leader>qa", "<cmd>qa<cr>", "Quit all")

-- window navigation
map("n", "<leader>wj", "<C-w>j", "Move down a window")
map("n", "<leader>wk", "<C-w>k", "Move up a window")
map("n", "<leader>wh", "<C-w>h", "Move left a window")
map("n", "<leader>wl", "<C-w>l", "Move right a window")
map("n", "<leader>wo", "<C-w>o", "Close other windows")
map("n", "<leader>wb", "<C-o>", "Go back in the jump list")

-- Management tools like Lazy and Mason
map("n", "<leader>xl", "<cmd>Lazy<CR>", "Open Lazy")
map("n", "<leader>xm", "<cmd>Mason<CR>", "Open Mason")

-- Autocorrect pick first option
map("n", "<leader>c", "1z=<CR>", "Autocorrect word")

-- Markdown

-- Wrap the current word with a markdown link format and position the cursor to add link text.
-- Steps:
-- 1. `ciW`: Change the current "WORD" (the text under the cursor) to prepare it for wrapping.
-- 2. `[](<C-r>")`: Wrap the word in `[]()` syntax, inserting the original word from the default `"` register into `[]`.
--    The `"` register stores the last yanked or changed text (in this case, the word under the cursor).
-- 3. `<Esc>F]`: Exit insert mode and move the cursor back to the starting `[` for text entry.
-- 4. `i`: Enter insert mode so you can add the link text inside `[]`.
map("n", "<leader>ma", 'ciW[](<C-r>")<Esc>F]i', "Wrap WORD with link - add text")

-- Wrap the current word with a markdown link format and position the cursor to add the URL.
-- Steps:
-- 1. `ciW`: Change the current "WORD" to prepare it for wrapping.
-- 2. `[<C-r>"]()`: Wrap the word in `[]()` syntax, inserting the original word from the default `"` register into `[]`.
--    The `"` register stores the last yanked or changed text (in this case, the word under the cursor).
-- 3. `<Esc>i`: Exit insert mode and immediately re-enter insert mode at `(` for URL entry.
map("n", "<leader>mu", 'ciW[<C-r>"]()<Esc>i', "Wrap WORD with link - add URL")

-- Visual selection variant of the above
-- Wrap the current visual selection with a markdown link format and position the cursor to add the URL.
map("v", "<leader>mv", 'c[<C-r>"]()<Esc>i', "Wrap visual selection with link - add URL")

-- Wrap the current word with a markdown embed format and position the cursor to add text.
map("n", "<leader>me", 'ciW![](<C-r>")<Esc>F]i', "Wrap WORD with embed - add text")
