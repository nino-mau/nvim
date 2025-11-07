return {
  "saghen/blink.cmp",
  opts = {
    signature = { enabled = true },
    keymap = {
      ["<Tab>"] = { "select_next", "accept", "fallback" },
      ["<S-Tab>"] = { "select_prev", "accept", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
    },
    completion = {
      ghost_text = {
        enabled = false,
      },
      menu = {
        scrollbar = false,
        draw = {
          components = {
            kind_icon = {
              ellipsis = false,
              text = function(ctx)
                local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                return kind_icon .. " "
              end,
            },
          },
        },
      },
    },
  },
}
