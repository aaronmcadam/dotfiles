local M = {}

function M.opts()
  return {
    keymap = {
      preset = "default",
      -- These are the default Neovim completion keybindings:
      -- <C-n> - Select next item
      -- <C-p> - Select previous item
      -- <C-y> - Accept ([y]es) the completion
      -- <C-Space> - Manually trigger a completion
      -- <C-e> - Abort the completion (hides the menu)

      -- These are custom keybindings:
      -- Think of <C-l> as moving to the right of your snippet expansion.
      --  So if you have a snippet that's like:
      --  function $name($args)
      --    $body
      --  end
      --
      -- <C-l> will move you to the right of each of the expansion locations.
      -- <C-h> is similar, except moving you backwards.
      -- ["<C-l>"] = { "snippet_forward", "fallback" },
      ["<C-l>"] = {
        "snippet_forward",
        function()
          return require("sidekick").nes_jump_or_apply()
        end,
        "fallback",
      },
      ["<C-h>"] = { "snippet_backward", "fallback" },
    },
    completion = {
      menu = {
        border = "single",
        draw = {
          treesitter = { "lsp" },
        },
      },
      -- Show documentation when selecting a completion item
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        window = {
          border = "single",
        },
      },
    },
    sources = {
      default = {
        "snippets",
        "lsp",
        "buffer",
        "path",
      },
      providers = {
        lsp = {
          enabled = function()
            -- We want to use the obsidian completion source for markdown
            -- to avoid entries for both marksman and obsidian.
            return vim.bo.filetype ~= "markdown"
          end,
        },
        buffer = {
          enabled = function()
            -- We want to avoid words from the buffer completions in markdown
            -- so the note link completions are prioritised within Obisidian notes.
            return vim.bo.filetype ~= "markdown"
          end,
        },
      },
    },
    cmdline = {
      enabled = false,
    },
  }
end

return M

