local function augroup(name)
  return vim.api.nvim_create_augroup("azvim_" .. name, { clear = true })
end

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  desc = "Check if we need to reload the file when it changed",
  group = augroup("checktime"),
  command = "checktime",
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- resize splits if window gets resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  desc = "Resize splits if window gets resized",
  group = augroup("resize_splits"),
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- go to last location when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  desc = "Go to last location when opening a buffer",
  group = augroup("last_loc"),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  desc = "Close some filetypes with <q>",
  group = augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "neotest-output",
    "checkhealth",
    "neotest-summary",
    "neotest-output-panel",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  desc = "Auto create dir when saving a file if it doesn't exist",
  group = augroup("auto_create_dir"),
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- Fixes Autocomment
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  desc = "Fixes Autocomment",
  callback = function()
    vim.cmd("set formatoptions-=cro")
  end,
})

-- Enable prose tools for markdown files
vim.api.nvim_create_autocmd("FileType", {
  desc = "Prose tools for markdown files",
  group = augroup("prose"),
  pattern = {
    "markdown",
  },
  callback = function()
    -- Set Pencil's conceallevel to 2 to avoid Obsidian.nvim warning
    vim.api.nvim_set_var("pencil#conceallevel", 2)
    -- enable Pencil
    vim.cmd("PencilSoft")
    -- set spell check
    vim.opt_local.spell = true
    -- insert 2 spaces for a tab (this is my default but its getting to 4 in markdown files for some reason)
    vim.opt_local.shiftwidth = 2
  end,
})
