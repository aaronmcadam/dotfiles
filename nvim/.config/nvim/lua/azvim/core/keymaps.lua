local map = require("azvim.helpers.keys").map


map("n", "<leader>w", "<cmd>w<cr>", "Write")

-- Diagnostic keymaps
map('n', 'gx', vim.diagnostic.open_float, "Show diagnostics under cursor")

-- Stay in indent mode
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Clear after search
map("n", "<leader><leader>", "<cmd>nohl<cr>", "Clear highlights")
