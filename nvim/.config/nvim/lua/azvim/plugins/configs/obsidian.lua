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
      folder = "50 Resources/51 Attachments",
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
