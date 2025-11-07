return {
  "axelvc/template-string.nvim",
  event = "BufReadPost", -- load on file open
  dependencies = {
    "nvim-treesitter/nvim-treesitter", -- required for language parsing
  },
  config = function()
    require("template-string").setup({
      -- optional settings; these are the defaults:
      filetypes = {
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact",
        "vue",
        "svelte",
        "python",
        "cs",
      },
      jsx_brackets = true, -- wrap JSX attrs in `{``}`
      remove_template_string = false, -- don't auto-remove backticks
      restore_quotes = {
        normal = [[']], -- quote style if removed
        jsx = [["]],
      },
    })
  end,
}
