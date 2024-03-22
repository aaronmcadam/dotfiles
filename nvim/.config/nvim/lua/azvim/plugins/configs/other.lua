local M = {}

function M.setup()
  require("other-nvim").setup({
    rememberBuffers = false,
    hooks = {
      -- This hook is called whenever the plugin tries to find other files.
      -- It returns the matches found by the plugin. It can be used to filter or reorder the files or use the matches with another plugin.
      --
      -- @param matches (table) lua table with each entry containing: (filename (string), context (string), exists (boolean))
      -- @return (matches) Make sure to return the matches, otherwise the plugin will not work as expected.
      onFindOtherFiles = function(matches)
        local filteredMatches = {}
        local matcherForTS = nil
        local matcherForTSX = nil

        for _, match in ipairs(matches) do
          if match.context == "story" then
            -- Identify and store the matchers for .ts and .tsx files
            if match.filename:match("%.tsx$") then
              matcherForTSX = match
            else
              matcherForTS = match
            end
          else
            -- Add non-story matches directly
            table.insert(filteredMatches, match)
          end
        end

        -- Decide which story file matcher to use
        if matcherForTSX and matcherForTSX.exists then
          -- Use the .tsx file if it exists
          table.insert(filteredMatches, matcherForTSX)
        elseif matcherForTS then
          -- Default to the .ts file if no .tsx file exists
          table.insert(filteredMatches, matcherForTS)
        end

        return filteredMatches
      end,
    },
    mappings = {
      "rails",
      {
        pattern = "/(.*)/(.*).ts(.*)$",
        target = {
          {
            target = "/%1/%2.test.ts%3",
            context = "test",
          },
          {
            target = "/%1/%2.stories.ts",
            context = "story",
          },
          {
            target = "/%1/%2.stories.tsx",
            context = "story",
          },
        },
      },
      {
        pattern = "/(.*)/(.*).test.ts(.*)$",
        target = {
          {
            target = "/%1/%2.ts%3",
            context = "implementation",
          },
          {
            target = "/%1/%2.stories.ts",
            context = "story",
          },
          {
            target = "/%1/%2.stories.tsx",
            context = "story",
          },
        },
      },
      {
        pattern = "/(.*)/(.*).stories.tsx$",
        target = {
          {
            target = "/%1/%2.tsx",
            context = "implementation",
          },
          {
            target = "/%1/%2.test.tsx",
            context = "test",
          },
        },
      },
    },
  })
end

function M.keys()
  return {
    { "<leader>kk", "<cmd>Other<CR>", desc = "Open related file" },
    { "<leader>kv", "<cmd>OtherVSplit<CR>", desc = "Open related file in split" },
    { "<leader>kt", "<cmd>OtherVSplit test<CR>", desc = "Open test" },
    { "<leader>ks", "<cmd>OtherVSplit story<CR>", desc = "Open story" },
    { "<leader>ki", "<cmd>OtherVSplit implementation<CR>", desc = "Open implementation" },
    { "<leader>kc", "<cmd>OtherClear<CR>", desc = "Clear related files" },
  }
end

return M
