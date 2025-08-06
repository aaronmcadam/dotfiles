local M = {}

function M.opts()
  return {
    open_cmd = "noswapfile vnew",
    replace_engine = {
      ["sed"] = {
        cmd = "sed",
        args = {
          "-i",
          "",
          "-E",
        },
      },
    },
  }
end

function M.keys()
  return {
    {
      "<leader>r",
      function()
        require("spectre").open()
      end,
      desc = "Replace in files (Spectre)",
    },
  }
end

return M