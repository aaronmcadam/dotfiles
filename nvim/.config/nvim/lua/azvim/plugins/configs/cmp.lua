local M = {}

function M.opts()
  local cmp = require("cmp")
  local luasnip = require("luasnip")

  return {
    completion = {
      completeopt = "menu,menuone,noinsert,noselect",
    },
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },

    -- These mappings are based on the latest kickstart.nvim changes.
    -- @see https://github.com/nvim-lua/kickstart.nvim/pull/635

    -- For an understanding of why these mappings were
    -- chosen, you will need to read `:help ins-completion`
    mapping = cmp.mapping.preset.insert({
      -- Select the [n]ext item
      ["<C-n>"] = cmp.mapping.select_next_item(),

      -- Select the [p]revious item
      ["<C-p>"] = cmp.mapping.select_prev_item(),

      -- Accept ([y]es) the completion.
      --  This will auto-import if your LSP supports it.
      --  This will expand snippets if the LSP sent a snippet.
      ["<C-y>"] = cmp.mapping.confirm({ select = true }),

      -- Manually trigger a completion from nvim-cmp.
      --  Generally you don't need this, because nvim-cmp will display
      --  completions whenever it has completion options available.
      ["<C-Space>"] = cmp.mapping.complete(),

      -- Think of <c-l> as moving to the right of your snippet expansion.
      --  So if you have a snippet that's like:
      --  function $name($args)
      --    $body
      --  end
      --
      -- <c-l> will move you to the right of each of the expansion locations.
      -- <c-h> is similar, except moving you backwards.
      ["<C-l>"] = cmp.mapping(function()
        if luasnip.expand_or_locally_jumpable() then
          luasnip.expand_or_jump()
        end
      end, { "i", "s" }),
      ["<C-h>"] = cmp.mapping(function()
        if luasnip.locally_jumpable(-1) then
          luasnip.jump(-1)
        end
      end, { "i", "s" }),

      ["<C-e>"] = cmp.mapping.abort(),
      ["<C-u>"] = cmp.mapping.scroll_docs(-4),
      ["<C-d>"] = cmp.mapping.scroll_docs(4),
    }),
    formatting = {
      format = function(_, item)
        local icons = require("azvim.core.helpers").icons.kinds

        if icons[item.kind] then
          item.kind = icons[item.kind] .. item.kind
        end

        return item
      end,
    },
    sources = cmp.config.sources({
      { name = "nvim_lsp", priority = 1000 },
      { name = "luasnip", priority = 800 },
      { name = "git", priority = 600 },
      { name = "copilot", priority = 600 },
      { name = "buffer", priority = 400 },
      { name = "path", priority = 250 },
    }),
  }
end

return M
