local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
	return
end

toggleterm.setup({
	size = 20,
	open_mapping = [[<c-\>]],
	hide_numbers = true,
	shade_terminals = true,
	shading_factor = 2,
	start_in_insert = true,
	insert_mappings = true,
	persist_size = true,
	direction = "float",
	float_opts = {
		border = "curved",
	},
})

function _G.set_terminal_keymaps()
	local opts = { noremap = true }

	vim.api.nvim_buf_set_keymap(0, "t", "<C-[>", [[<C-\><C-n>]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-u>", [[<C-\><C-n><C-u>]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-d>", [[<C-\><C-n><C-d>]], opts)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({
	cmd = "lazygit",
	hidden = true,
	on_open = function(term)
		local opts = { noremap = true, silent = true }

		vim.cmd("startinsert!")
		vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", opts)
		-- Reset keymaps so that we can use lazygit's keymaps.
		vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<C-[>", [[<C-[>]], opts)
		vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<C-u>", [[<C-u>]], opts)
		vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<C-d>", [[<C-d>]], opts)
	end,
})

function _LAZYGIT_TOGGLE()
	lazygit:toggle()
end
