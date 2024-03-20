local M = {}

function M.opts()
  return {
    workspaces = {
      {
        name = "Remote Second Brain",
        path = "~/Documents/Remote Second Brain/",
      },
    },
    notes_subdir = "30 Areas/31 Inbox",
    new_notes_location = "notes_subdir",
    templates = {
      subdir = "50 Resources/54 Templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
    },
    daily_notes = {
      folder = "40 Journal/41 Daily Notes/2024",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
      template = "OTPL Daily Note.md",
    },
    mappings = {},
    -- Optional, set to true to force ':ObsidianOpen' to bring the app to the foreground.
    open_app_foreground = true,
    -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
    -- URL it will be ignored but you can customize this behavior here.
    ---@param url string
    follow_url_func = function(url)
      -- Open the URL in the default web browser.
      vim.fn.jobstart({ "open", url }) -- Mac OS
      -- vim.fn.jobstart({"xdg-open", url})  -- linux
    end,
    note_id_func = function(title)
      return title
    end,
    note_frontmatter_func = function(note)
      if note.title then
        note:add_alias(string.lower(note.title))
      end

      -- Only add the "permanent-notes" tag for new or existing notes without tags.
      -- This avoids adding a tag where it's not wanted.
      if note.tags and #note.tags == 0 then
        note:add_tag("permanent-notes")
      end

      local date_format = "%Y-%m-%d"
      local out = {
        aliases = note.aliases,
        tags = note.tags,
        created = os.date(date_format),
      }

      -- `note.metadata` contains any manually added fields in the frontmatter.
      -- So here we just make sure those fields are kept in the frontmatter.
      if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
        for k, v in pairs(note.metadata) do
          out[k] = v
        end
      end

      return out
    end,
    -- Optional, customize the default name or prefix when pasting images via `:ObsidianPasteImg`.
    ---@return string
    image_name_func = function()
      -- Prefix image names with timestamp.
      return string.format("%s-image", os.time())
    end,
    attachments = {
      -- The default folder to place images in via `:ObsidianPasteImg`.
      -- If this is a relative path it will be interpreted as relative to the vault root.
      -- You can always override this per image by passing a full path to the command instead of just a filename.
      img_folder = "50 Resources/51 Attachments",
      img_text_func = function(client, path)
        ---@type string
        local link_path
        local vault_relative_path = client:vault_relative_path(path)
        if vault_relative_path ~= nil then
          -- Use relative path if the image is saved in the vault dir.
          link_path = tostring(vault_relative_path)
        else
          -- Otherwise use the absolute path.
          link_path = tostring(path)
        end
        local display_name = vim.fs.basename(link_path)
        return string.format("![[%s]]", display_name)
      end,
      confirm_img_paste = false,
    },
  }
end

function M.keys()
  return {
    {
      "gf",
      function()
        return require("obsidian").util.gf_passthrough()
      end,
      desc = "Open link",
      noremap = false,
      expr = true,
      buffer = true,
    },
    {
      "<leader>nn",
      "<cmd>ObsidianNew<cr>",
      desc = "Create new note",
    },
    {
      "<leader>nb",
      "<cmd>ObsidianBacklinks<cr>",
      desc = "Show backlinks for current note",
    },
    {
      "<leader>nc",
      function()
        return require("obsidian").util.toggle_checkbox()
      end,
      desc = "Toggle checkboxes",
      buffer = true,
    },
    {
      "<leader>nt",
      "<cmd>ObsidianToday<cr>",
      desc = "Open new Daily Note",
    },
    {
      "<leader>ny",
      "<cmd>ObsidianYesterday<cr>",
      desc = "Open yesterday's Daily Note",
    },
    {
      "<leader>nf",
      "<cmd>ObsidianFollowLink<cr>",
      desc = "Follow link",
    },
    {
      "<leader>no",
      "<cmd>ObsidianOpen<cr>",
      desc = "Open note in Obsidian",
    },
    {
      "<leader>nq",
      "<cmd>ObsidianQuickSwitch<cr>",
      desc = "Switch to another note",
    },
    {
      "<leader>ns",
      "<cmd>ObsidianSearch<cr>",
      desc = "Search notes",
    },
    {
      "<leader>nm",
      "<cmd>ObsidianTemplate<cr>",
      desc = "Insert template",
    },
    {
      "<leader>np",
      "<cmd>ObsidianPasteImg<cr>",
      desc = "Paste image",
    },
    {
      "<leader>nll",
      "<cmd>ObsidianLink<cr>",
      desc = "Link selection",
      mode = "v",
    },
    {
      "<leader>nln",
      "<cmd>ObsidianLinkNew<cr>",
      desc = "Create and link new note",
      mode = "v",
    },
  }
end

return M
