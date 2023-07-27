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

-- Clear search highlights
map("n", "<Leader><Leader>", "<cmd>noh<CR>", "Clear search")

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

-- save file
map("n", "<leader>s", "<cmd>w<cr><esc>", "Save file")

-- quit
map("n", "<leader>qq", "<cmd>qa<cr>", "Quit all")

-- window navigation
map("n", "<leader>wj", "<C-w>j", "Move down a window")
map("n", "<leader>wk", "<C-w>k", "Move up a window")
map("n", "<leader>wh", "<C-w>h", "Move left a window")
map("n", "<leader>wl", "<C-w>l", "Move right a window")
map("n", "<leader>wo", "<C-w>o", "Close other windows")
map("n", "<leader>wb", "<C-o>", "Go back in the jump list")

local Job = require("plenary.job")

local function getURLTitle(url, callback)
  if not url:find("^https?://") then
    return
  end

  Job
    :new({
      command = "python3",
      args = {
        "-c",
        string.format(
          "import bs4, requests; print(bs4.BeautifulSoup(requests.get('%s').content, 'lxml').title.text.strip())",
          url
        ),
      },
      on_exit = function(j, return_val)
        if return_val == 0 then
          local result = j:result()
          local title = result[1] -- get the first line of the result
          if title ~= "" then
            callback(title)
          else
            print("No title found. Full result:", result)
          end
        else
          print("Error getting title:", j:stderr_result()[1]) -- print the first line of stderr
        end
      end,
    })
    :start()
end

local function checkForURL(line, callback)
  local url = line:match("https?://[%w-_%.%?%.:/%+=&]+")

  if url then
    getURLTitle(url, function(title)
      local mdLink = string.format("[%s](%s)", title, url)
      local newLine = line:gsub(url, mdLink, 1)
      callback(newLine)
    end)
  else
    callback(line)
  end
end

-- Add link titles when pasting a link
function _G.PasteMDLink()
  local clipboard_contents = vim.fn.getreg("+")

  checkForURL(clipboard_contents, function(newLine)
    vim.schedule(function()
      vim.api.nvim_put({ newLine }, "l", true, true)
    end)
  end)
end

-- Make a keybinding (mnemonic: "mark down paste")
vim.api.nvim_set_keymap("n", "<Leader>mp", ":lua PasteMDLink()<cr>", { noremap = true, silent = true })
