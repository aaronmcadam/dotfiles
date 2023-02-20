local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

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
keymap("n", "<Leader>r", "<cmd>lua require('user.core.utils').reload_config()<CR>", opts)

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

-- Git
keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts)
keymap("n", "<Leader>gb", vim.cmd.GBrowse, opts)
keymap("n", "<Leader>gc", "<cmd>G commit<CR>", opts)
keymap("n", "<Leader>gd", vim.cmd.Gdiffsplit, opts)
keymap("n", "<Leader>gp", "<cmd>G push<CR>", opts)
keymap("n", "<Leader>gr", vim.cmd.Gread, opts)
keymap("n", "<Leader>gs", vim.cmd.Git, opts)
keymap("n", "<Leader>gw", vim.cmd.Gwrite, opts)

-- Telescope
keymap(
	"n",
	"<Leader>ff",
	"<cmd>lua require('user.plugins.configs.telescope').project_files()<CR>",
	{ desc = "[F]ind [F]ile" }
)
keymap("n", "<Leader>/", function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "[/] Fuzzily search in current buffer" })
keymap("n", "<Leader>ft", require("telescope.builtin").live_grep, { desc = "[F]ind [T]ext" })
keymap("n", "<Leader>fw", require("telescope.builtin").grep_string, { desc = "[F]ind current [W]ord" })
keymap("n", "<Leader>fb", require("telescope.builtin").buffers, { desc = "[F]ind existing [B]uffers" })
keymap("n", "<Leader>fd", require("telescope.builtin").diagnostics, { desc = "[F]ind [D]iagnostics" })
keymap("n", "<Leader>fh", require("telescope.builtin").help_tags, { desc = "[F]ind [H]elp" })
keymap("n", "<Leader>fk", require("telescope.builtin").keymaps, { desc = "[F]ind [K]eymapping" })
keymap("n", "<Leader>fs", require("telescope.builtin").lsp_document_symbols, { desc = "LSP: [F]ind [S]ymbols" })
keymap("n", "<Leader>fr", require("telescope.builtin").oldfiles, { desc = "[F]ind [R]ecently opened files" })
-- Go to definition
keymap("n", "<Leader>fg", "<cmd>lua require('telescope.builtin').lsp_definitions({ jump_type='vsplit' })<CR>", opts)
keymap("n", "<c-]>", "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>", opts)
keymap("n", "<c-w><c-]>", "<cmd>lua require('telescope.builtin').lsp_definitions({ jump_type='vsplit' })<CR>", opts)
keymap("n", "gs", "<cmd>lua require('telescope.builtin').lsp_definitions({ jump_type='split' })<CR>", opts)
-- Harpoon marks
keymap("n", "<Leader>fm", "<cmd>Telescope harpoon marks<CR>", opts)

-- Harpoon
keymap("n", "<Leader>ha", "<cmd>lua require('harpoon.mark').add_file()<CR>", opts)
keymap("n", "<Leader>hm", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", opts)
keymap("n", "<Leader>hh", "<cmd>lua require('harpoon.ui').nav_file(1)<CR>", opts)
keymap("n", "<Leader>hj", "<cmd>lua require('harpoon.ui').nav_file(2)<CR>", opts)
keymap("n", "<Leader>hk", "<cmd>lua require('harpoon.ui').nav_file(3)<CR>", opts)
keymap("n", "<Leader>hl", "<cmd>lua require('harpoon.ui').nav_file(4)<CR>", opts)

-- Related buffer navigation
keymap("n", "<Leader>kk", "<cmd>Other<CR>", opts)
keymap("n", "<Leader>kv", "<cmd>OtherVSplit<CR>", opts)
keymap("n", "<Leader>kc", "<cmd>OtherClear<CR>", opts)
keymap("n", "<Leader>kt", "<cmd>OtherVSplit test<CR>", opts)
keymap("n", "<Leader>ks", "<cmd>OtherVSplit story<CR>", opts)
keymap("n", "<Leader>ki", "<cmd>OtherVSplit implementation<CR>", opts)

-- Tests
keymap("n", "<Leader>tt", "<cmd>w<CR><cmd>TestNearest<CR>", opts)
keymap("n", "<Leader>tf", "<cmd>w<CR><cmd>TestFile<CR>", opts)
keymap("n", "<Leader>tl", "<cmd>w<CR><cmd>TestLast<CR>", opts)
keymap("n", "<Leader>tv", "<cmd>w<CR><cmd>TestVisit<CR>", opts)
keymap("n", "<Leader>tp", "<cmd>w<CR><cmd>Playwright<CR>", opts)

-- Debugging
-- keymap("n", "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<cr>", opts)
-- keymap("n", "<leader>dc", "<cmd>lua require('dap').continue()<cr>", opts)
-- keymap("n", "<leader>di", "<cmd>lua require('dap').step_into()<cr>", opts)
-- keymap("n", "<leader>do", "<cmd>lua require('dap').step_over()<cr>", opts)
-- keymap("n", "<leader>dO", "<cmd>lua require('dap').step_out()<cr>", opts)
-- keymap("n", "<leader>dr", "<cmd>lua require('dap').repl.toggle()<cr>", opts)
-- keymap("n", "<leader>dl", "<cmd>lua require('dap').run_last()<cr>", opts)
-- keymap("n", "<leader>du", "<cmd>lua require('dapui').toggle()<cr>", opts)
-- keymap("n", "<leader>dt", "<cmd>lua require('dap').terminate()<cr>", opts)

-- undo tree
keymap("n", "<Leader>u", vim.cmd.UndotreeToggle, opts)
