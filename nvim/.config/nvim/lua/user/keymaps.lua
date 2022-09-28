local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Normal mode --
-- Avoid invalid commands by avoiding the shift key for commands
keymap("n", ";", ":", opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- File navigation
keymap("n", "-", ":Ex<CR>", opts)

-- Less jarring paging
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "<C-d>", "<C-d>zz", opts)

-- Resize with arrows
keymap("n", "<A-Up>", ":resize -2<CR>", opts)
keymap("n", "<A-Down>", ":resize +2<CR>", opts)
keymap("n", "<A-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<A-Right>", ":vertical resize +2<CR>", opts)

-- Leader mappings
keymap("n", "<Leader><Leader>", "<cmd>noh<CR>", opts)

-- Better paste that doesn't lose what was in the paste register when we want to replace the selected text.
-- We delete to the Black Hole register ("_") so that our paste register will keep the text that we copied.
-- @see https://youtu.be/qZO9A5F6BZs?t=352
keymap("n", "<Leader>p", "\"_dP", opts)
keymap("v", "<Leader>p", "\"_dP", opts)

-- Better delete
keymap("n", "<Leader>d", "\"_d")
keymap("v", "<Leader>d", "\"_d")

--- copy to system clipboard
keymap("n", "<Leader>y", "\"+y", opts)
keymap("n", "<Leader>Y", "\"+Y", opts)
keymap("v", "<Leader>y", "\"+y", opts)

-- Lazygit
keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts)

-- Telescope
-- Find file
keymap("n", "<Leader>ff", "<cmd>lua require('user.telescope').project_files()<CR>", opts)
-- File viewer
keymap("n", "<Leader>fv", "<cmd>Telescope file_browser<CR>", opts)
-- Find text
keymap("n", "<Leader>ft", "<cmd>Telescope live_grep<CR>", opts)
-- Find word
keymap("n", "<Leader>fw", "<cmd>Telescope grep_string<CR>", opts)
-- Find buffer
keymap("n", "<Leader>fb", "<cmd>Telescope buffers<CR>", opts)
-- Go to definition
keymap("n", "<Leader>fd", "<cmd>lua require('telescope.builtin').lsp_definitions({ jump_type='vsplit' })<CR>", opts)
keymap("n", "<c-]>", "<cmd>lua require('telescope.builtin').lsp_definitions({ jump_type='vsplit' })<CR>", opts)
keymap("n", "gs", "<cmd>lua require('telescope.builtin').lsp_definitions({ jump_type='split' })<CR>", opts)
-- Harpoon marks
keymap("n", "<Leader>fm", "<cmd>Telescope harpoon marks<CR>", opts)

-- Harpoon
keymap("n", "<Leader>hm", "<cmd>lua require('harpoon.mark').add_file()<CR>", opts)
keymap("n", "<Leader>hh", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", opts)

-- Related buffer navigation
keymap("n", "<Leader>kk", "<cmd>Other<CR>", opts)
keymap("n", "<Leader>kv", "<cmd>OtherVSplit<CR>", opts)
keymap("n", "<Leader>kc", "<cmd>OtherClear<CR>", opts)
keymap("n", "<Leader>kt", "<cmd>OtherVSplit test<CR>", opts)
keymap("n", "<Leader>ks", "<cmd>OtherVSplit story<CR>", opts)
keymap("n", "<Leader>ki", "<cmd>OtherVSplit implementation<CR>", opts)

keymap("n", "<Leader>q", "<cmd>qa<CR>", opts)
keymap("n", "<Leader>r", "<cmd>lua require('user.utils').reload_config()<CR>", opts)
keymap("n", "<Leader>tt", "<cmd>lua require('neotest').run.run()<CR>", opts)
keymap("n", "<Leader>td", "<cmd>lua require('neotest').run.run({ strategy = 'dap' })<CR>", opts)
keymap("n", "<Leader>tf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>", opts)
keymap("n", "<Leader>tl", "<cmd>lua require('neotest').run.run_last()<CR>", opts)
keymap("n", "<Leader>ts", "<cmd>lua require('neotest').summary.toggle()<CR>", opts)
keymap("n", "<Leader>tr", "<cmd>lua require('neotest').output.open({ enter = true })<CR>", opts)

-- Debugging tests:
-- keymap("n", "<Leader>ta", '<cmd>lua require("neotest").run.attach()<CR>', opts)
-- keymap('n', '<Leader>td', '<cmd>lua require("neotest").run.run({ strategy = "dap" })<CR>', opts)
-- DAP
keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)
keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts)
keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts)
keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts)
