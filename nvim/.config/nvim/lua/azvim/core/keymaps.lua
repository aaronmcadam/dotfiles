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
map("n", "<leader>qa", "<cmd>qa!<cr>", "Quit all without saving")

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
map("n", "<leader>ma", 'ciW[](<C-r>")<Esc>F]i', "Add link text")

-- Wrap the current word with a markdown link format and position the cursor to add the URL.
-- Steps:
-- 1. `ciW`: Change the current "WORD" to prepare it for wrapping.
-- 2. `[<C-r>"]()`: Wrap the word in `[]()` syntax, inserting the original word from the default `"` register into `[]`.
--    The `"` register stores the last yanked or changed text (in this case, the word under the cursor).
-- 3. `<Esc>i`: Exit insert mode and immediately re-enter insert mode at `(` for URL entry.
map("n", "<leader>mu", 'ciW[<C-r>"]()<Esc>i', "Add link URL")

-- Visual selection variant of the above
-- Wrap the current visual selection with a markdown link format and position the cursor to add the URL.
map("v", "<leader>mv", 'c[<C-r>"]()<Esc>i', "Wrap with link URL")

-- Wrap the current word with a markdown embed format and position the cursor to add text.
map("n", "<leader>me", 'ciW![](<C-r>")<Esc>F]i', "Wrap with embed link text")

-- Wrap the current word with code backticks.
map("n", "<leader>mc", 'ciW`<C-r>"`<Esc>wi', "Wrap word with code backticks")

-- I'm going to attempt to implement an Auto Title URL Paster command for
-- [[Neovim]] today.
--
-- What should the command be able to do?
--
-- When I paste a link into a note, the command should:
--
-- 1. Fetch the title of the URL
-- 2. Insert a markdown link using the title as the title and the URL as the url
--
-- For example, if I copy and paste `https://github.com/`, the command should paste
-- the following into my markdown note:
--
-- ```md
-- [GitHub](https://github.com/)
-- ```

-- chat gpt's attempt:
local curl = require("plenary.curl")

-- Debug helper function
local function debug(msg)
  vim.schedule(function()
    vim.notify("[Auto Title URL Paster] " .. msg, vim.log.levels.INFO)
  end)
end

-- Function to sanitize URL (trim whitespace and ensure https://)
local function sanitize_url(url)
  debug("Original clipboard content: " .. url)
  url = url:gsub("^%s*(.-)%s*$", "%1") -- Trim spaces
  if not url:match("^https?://") then
    debug("URL missing scheme, prepending https://")
    url = "https://" .. url
  end
  debug("Sanitized URL: " .. url)
  return url
end

local function get_page_title(url, callback)
  debug("Fetching title for: " .. url)

  curl.request({
    url = url,
    method = "GET",
    headers = {
      ["User-Agent"] = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36",
      ["Accept-Language"] = "en-US,en;q=0.9",
    },
    redirect = true, -- Follow redirects
    callback = function(res)
      if not res or not res.status then
        debug("Request failed. No response received.")
        callback(url)
        return
      end

      debug("Response received with status: " .. res.status)

      if res.status ~= 200 then
        debug("Failed to fetch page. Status: " .. res.status)
        callback(url) -- Fallback if request fails
        return
      end

      debug("Extracting title from response...")

      local title = res.body and res.body:match("<title>(.-)</title>") or nil
      if not title or title == "" then
        debug("No title found. Using URL as fallback.")
        title = url
      else
        debug("Extracted title: " .. title)
      end

      title = title:gsub("\n", ""):gsub("\r", ""):gsub("^%s*(.-)%s*$", "%1") -- Trim spaces
      callback(title)
    end,
  })
end

-- Function to paste Markdown link
local function paste_markdown_link()
  local url = vim.fn.getreg("+") -- Get clipboard content
  debug("Clipboard content: " .. url)

  if not url:match("^https?://") then
    debug("Invalid URL detected in clipboard.")
    print("Clipboard does not contain a valid URL")
    return
  end

  url = sanitize_url(url)

  debug("Valid URL detected. Fetching title...")

  -- Fetch the title and paste the Markdown link
  get_page_title(url, function(title)
    debug("Formatting Markdown link...")

    local markdown_link = string.format("[%s](%s)", title, url)

    vim.schedule(function()
      vim.api.nvim_put({ markdown_link }, "", true, true) -- Paste at cursor
      debug("Pasted Markdown link: " .. markdown_link)
    end)
  end)
end

-- Define the user command `:PasteMarkdownURL`
vim.api.nvim_create_user_command("PasteMarkdownURL", paste_markdown_link, {})

map("n", "<leader>mp", "<cmd>PasteMarkdownURL<CR>", "Paste markdown link")
