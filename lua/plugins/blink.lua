return {
  "saghen/blink.cmp",
  opts = {
    signature = { enabled = true },
    keymap = {
      ["<Tab>"] = { "select_next", "accept", "fallback" },
      ["<S-Tab>"] = { "select_prev", "accept", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
    },
    sources = {
      providers = {
        lsp = {
          score_offset = 1000,
        },
        snippets = {
          score_offset = 500,
        },
      },
    },
    completion = {
      ghost_text = {
        enabled = false,
      },
    },
  },
}
