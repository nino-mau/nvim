return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      exclude = {
        "node_modules",
        -- ".nuxt/dev",
        -- ".nuxt/dist",
        ".nuxt/ui",
        -- ".nuxt/manifest",
        -- ".nuxt/schema",
        -- ".nuxt/*.json",
        ".output",
        ".pnpm-store",
      },
      include = { ".nuxt/types" },
      win = {
        input = {
          keys = {
            ["<Tab>"] = { "list_down", mode = { "i", "n" } },
            ["<S-Tab>"] = { "list_up", mode = { "i", "n" } },
          },
        },
        list = {
          keys = {
            ["<Tab>"] = "list_down",
            ["<S-Tab>"] = "list_up",
          },
        },
      },
      sources = {
        files = {
          hidden = true,
          ignored = true,
        },
      },
    },
  },
}
