return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      -- jsonc = { "prettier" },
      html = { "djlint" },
      htmldjango = { "djlint" },
      -- json = { "prettier" },
      svg = { "prettier" },
      java = { "google_java_format" },
      sql = { "sql_formatter" },
      vue = { "biome_vue" },
    },
    formatters = {
      prettier = {
        prepend_args = {
          "--trailing-comma",
          "none",
          "--tab-width",
          "2",
          "--single-quote",
          "true",
        },
      },
      biome = {
        command = "biome",
        args = { "check", "--write", "--stdin-file-path", "$FILENAME" },
        stdin = true,
      },
      biome_vue = {
        command = "biome",
        args = { "format", "--stdin-file-path", "$FILENAME" },
        stdin = true,
      },
    },
  },
}
