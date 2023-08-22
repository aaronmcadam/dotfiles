local M = {}

function M.setup(_, opts)
  require("obsidian").setup(opts)

  -- Optional, override the 'gf' keymap to utilize Obsidian's search functionality.
  -- see also: 'follow_url_func' config option above.
  vim.keymap.set("n", "gf", function()
    if require("obsidian").util.cursor_on_markdown_link() then
      return "<cmd>ObsidianFollowLink<CR>"
    else
      return "gf"
    end
  end, { noremap = false, expr = true })
end

function M.opts()
  return {
    dir = "~/Documents/Remote Second Brain", -- no need to call 'vim.fn.expand' here

    -- Optional, if you keep notes in a specific subdirectory of your vault.
    notes_subdir = "000 Zettelkasten",

    -- Optional, set the log level for Obsidian. This is an integer corresponding to one of the log
    -- levels defined by "vim.log.levels.*" or nil, which is equivalent to DEBUG (1).
    log_level = vim.log.levels.DEBUG,

    -- daily_notes = {
    --   -- Optional, if you keep daily notes in a separate directory.
    --   folder = "notes/dailies",
    --   -- Optional, if you want to change the date format for daily notes.
    --   date_format = "%Y-%m-%d",
    -- },

    -- Optional, completion.
    completion = {
      -- If using nvim-cmp, otherwise set to false
      nvim_cmp = true,
      -- Trigger completion at 2 chars
      min_chars = 2,
      -- Where to put new notes created from completion. Valid options are
      --  * "current_dir" - put new notes in same directory as the current buffer.
      --  * "notes_subdir" - put new notes in the default notes subdirectory.
      new_notes_location = "current_dir",
    },

    mappings = {},

    -- Optional, customize how names/IDs for new notes are created.
    note_id_func = function(title)
      return title
    end,

    disable_frontmatter = true, -- set to true to disable Obsidian frontmatter

    templates = {
      subdir = "Templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
    },

    -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
    -- URL it will be ignored but you can customize this behavior here.
    follow_url_func = function(url)
      -- Open the URL in the default web browser.
      vim.fn.jobstart({ "open", url }) -- Mac OS
    end,

    -- Optional, set to true if you use the Obsidian Advanced URI plugin.
    -- https://github.com/Vinzent03/obsidian-advanced-uri
    -- use_advanced_uri = true,

    -- Optional, set to true to force ':ObsidianOpen' to bring the app to the foreground.
    open_app_foreground = true,

    -- Optional, by default commands like `:ObsidianSearch` will attempt to use
    -- telescope.nvim, fzf-lua, and fzf.nvim (in that order), and use the
    -- first one they find. By setting this option to your preferred
    -- finder you can attempt it first. Note that if the specified finder
    -- is not installed, or if it the command does not support it, the
    -- remaining finders will be attempted in the original order.
    finder = "telescope.nvim",
  }
end

function M.keys()
  return {
    {
      "<leader>ob",
      "<cmd>ObsidianBacklinks<cr>",
      desc = "Show backlinks for current note",
    },
    {
      "<leader>od",
      "<cmd>ObsidianToday<cr>",
      desc = "Open new Daily Note",
    },
    {
      "<leader>of",
      "<cmd>ObsidianFollowLink<cr>",
      desc = "Follow link",
    },
    {
      "<leader>on",
      "<cmd>ObsidianNew<cr>",
      desc = "Create new note",
    },
    {
      "<leader>oo",
      "<cmd>ObsidianOpen<cr>",
      desc = "Open note in Obsidian",
    },
    {
      "<leader>oll",
      "<cmd>ObsidianLink<cr>",
      desc = "Link selection",
    },
    {
      "<leader>oln",
      "<cmd>ObsidianLinkNew<cr>",
      desc = "Create and link new note",
    },
    {
      "<leader>oq",
      "<cmd>ObsidianQuickSwitch<cr>",
      desc = "Switch to another note",
    },
    {
      "<leader>os",
      "<cmd>ObsidianSearch<cr>",
      desc = "Search notes",
    },
    {
      "<leader>ot",
      "<cmd>ObsidianTemplate<cr>",
      desc = "Insert template",
    },
    {
      "<leader>oy",
      "<cmd>ObsidianYesterday<cr>",
      desc = "Open yesterday's Daily Note",
    },
  }
end

return M
