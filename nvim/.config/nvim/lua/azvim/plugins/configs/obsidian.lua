local M = {}

function M.opts()
  return {
    legacy_commands = false,
    ui = {
      enable = false,
    },
    workspaces = {
      {
        name = "Remote Second Brain",
        path = "~/Obsidian/Remote Second Brain/",
      },
    },
    completion = {
      nvim_cmp = false,
      blink = true,
      min_chars = 2,
    },
    notes_subdir = "30 Areas/31 Inbox",
    new_notes_location = "notes_subdir",
    templates = {
      folder = "50 Resources/54 Templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
    },
    daily_notes = {
      folder = "40 Journal/41 Daily Notes/2025",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
      template = "Daily Note.md",
    },
    open = {
      func = function(uri)
        vim.ui.open(uri, { cmd = { "open", "-a", "/Applications/Obsidian.app" } })
      end,
    },
    picker = {
      name = "snacks.pick",
    },
    -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
    -- URL it will be ignored but you can customize this behavior here.
    ---@param url string
    follow_url_func = function(url)
      vim.ui.open(url)
    end,
    note_id_func = function(title)
      return title
    end,
    frontmatter = {
      func = function(note)
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
    },
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
      "<cmd>Obsidian new_from_template<cr>",
      desc = "Create new note from template",
    },
    {
      "<leader>nb",
      "<cmd>Obsidian backlinks<cr>",
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
      "<leader>ne",
      ":Obsidian extract_note<cr>",
      mode = { "x" },
      desc = "Extract note",
    },
    {
      "<leader>nd", -- 'd' for 'day'
      "<cmd>Obsidian today<cr>",
      desc = "Open today's Daily Note",
    },
    {
      "<leader>nt",
      "<cmd>Obsidian tomorrow<cr>",
      desc = "Open tomorrow's Daily Note",
    },
    {
      "<leader>ny",
      "<cmd>Obsidian yesterday<cr>",
      desc = "Open yesterday's Daily Note",
    },
    {
      "<leader>nf",
      "<cmd>Obsidian follow_link<cr>",
      desc = "Follow link",
    },
    {
      "<leader>no",
      "<cmd>Obsidian open<cr>",
      desc = "Open note in Obsidian",
    },
    {
      "<leader>nq",
      "<cmd>Obsidian quick_switch<cr>",
      desc = "Switch to another note",
    },
    {
      "<leader>ns",
      "<cmd>Obsidian search<cr>",
      desc = "Search notes",
    },
    {
      "<leader>nm",
      "<cmd>Obsidian template<cr>",
      desc = "Insert template",
    },
    {
      "<leader>np",
      "<cmd>Obsidian paste_img<cr>",
      desc = "Paste image",
    },
    {
      "<leader>nr",
      "<cmd>Obsidian rename<cr>",
      desc = "Rename note",
    },
    {
      "<leader>nll",
      "<cmd>Obsidian link<cr>",
      desc = "Link selection",
      mode = "v",
    },
    {
      "<leader>nln",
      "<cmd>Obsidian link_new<cr>",
      desc = "Create and link new note",
      mode = "v",
    },
  }
end

return M
