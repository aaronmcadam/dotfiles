local M = {}

-- Dependencies
local curl = require("plenary.curl")

-- Configuration
local platform_names = {
  ["github"] = "GitHub",
  ["gitlab"] = "GitLab",
  ["jira"] = "Jira",
  ["slack"] = "Slack",
  ["notion"] = "Notion",
  ["figma"] = "Figma",
  ["discord"] = "Discord",
  ["linear"] = "Linear",
  ["confluence"] = "Confluence",
}

local is_debug_enabled = false

-- Debug helper function
local function debug(msg)
  if not is_debug_enabled then
    return
  end

  vim.schedule(function()
    vim.notify("[Markdown URL] " .. msg, vim.log.levels.INFO)
  end)
end

-- Decode HTML entities in title
local function decode_html_entities(str)
  return str:gsub("&amp;", "&"):gsub("&lt;", "<"):gsub("&gt;", ">"):gsub("&quot;", '"'):gsub("&#39;", "'")
end

-- Check if URL indicates a specific platform (fallback for generic error pages)
local function detect_platform_from_url(url)
  if not url then
    return nil
  end
  local url_lower = url:lower()

  -- Check URL patterns
  for pattern, display_name in pairs(platform_names) do
    if url_lower:find(pattern) then
      return display_name
    end
  end

  -- Special case: git* URLs that aren't GitHub should be treated as GitLab
  if url_lower:find("git") and not url_lower:find("github") then
    return "GitLab"
  end

  return nil
end

-- Check if title indicates a specific platform
local function detect_platform_from_title(title, url)
  if not title then
    return nil
  end
  local title_lower = title:lower()

  -- Check title content first
  for pattern, display_name in pairs(platform_names) do
    if title_lower:find(pattern) then
      return display_name
    end
  end

  -- If title detection fails (e.g., "403 Forbidden"), try URL fallback
  return detect_platform_from_url(url)
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

-- Function to get page title
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

      -- Always try to extract title from any response
      local title = res.body and res.body:match("<title[^>]*>(.-)</title>") or nil
      if title then
        title = decode_html_entities(title)
        title = title:gsub("%s+", " "):gsub("^%s*(.-)%s*$", "%1") -- Normalize whitespace
        debug("Extracted title: " .. title)
      end

      if res.status == 200 then
        -- For successful responses, use exact title
        callback(title or url)
      else
        -- For non-200 responses, try platform detection
        local platform = detect_platform_from_title(title, url)
        if platform then
          local platform_title = platform .. " - " .. url
          debug("Platform detected: " .. platform_title)
          callback(platform_title)
        else
          -- Use extracted title or URL as fallback
          callback(title or url)
        end
      end
    end,
  })
end

-- Public function to paste markdown link with auto title
function M.paste_auto_title()
  local url = vim.fn.getreg("+") -- Get clipboard content

  if not url or url == "" then
    vim.notify("Clipboard is empty", vim.log.levels.WARN)
    return
  end

  debug("Clipboard content: " .. url)

  if not url:match("^https?://") then
    debug("Invalid URL detected in clipboard.")
    vim.notify("Clipboard doesn't contain a valid URL", vim.log.levels.WARN)
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

-- Public function to paste markdown link with custom title
function M.paste_custom_title()
  local url = vim.fn.getreg("+")

  if not url or url == "" then
    vim.notify("Clipboard is empty", vim.log.levels.WARN)
    return
  end

  if not url:match("^https?://") then
    vim.notify("Clipboard doesn't contain a valid URL", vim.log.levels.WARN)
    return
  end

  url = sanitize_url(url)

  -- Show input dialog immediately
  local user_text = vim.fn.input("Link title: ")
  if user_text == "" then
    return
  end

  -- Detect platform in background and prepend to user text
  get_page_title(url, function(title)
    vim.schedule(function()
      local platform = detect_platform_from_title(title, url)
      local final_title = platform and (platform .. " - " .. user_text) or user_text

      local markdown_link = string.format("[%s](%s)", final_title, url)
      vim.api.nvim_put({ markdown_link }, "", true, true)
    end)
  end)
end

return M

