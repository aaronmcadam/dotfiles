local M = {}

function M.opts()
  local gen_bundled_spec = require("mini.ai").gen_spec
  local gen_extra_spec = require("mini.extra").gen_ai_spec
  return {
    n_lines = 500,
    custom_textobjects = {
      c = gen_bundled_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class
      d = gen_extra_spec.number(), -- digits
      f = gen_bundled_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
      g = gen_extra_spec.buffer(), -- buffer. g similar to G/gg motion
      i = gen_extra_spec.indent(),
      o = gen_bundled_spec.treesitter({ -- code block. o for "Outer"
        a = { "@block.outer", "@conditional.outer", "@loop.outer" },
        i = { "@block.inner", "@conditional.inner", "@loop.inner" },
      }),
      r = gen_extra_spec.line(), -- r for "Row"
      u = gen_bundled_spec.function_call(), -- u for "Usage"
      U = gen_bundled_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
      x = gen_extra_spec.diagnostic(), -- diagnostic
    },
  }
end

return M