return {
  "kylechui/nvim-surround",
  version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
  event = "VeryLazy",
  opts = {
    keymaps = {
      visual = "gS", -- surround selection in Visual mode
    },
  },
  config = function()
    require("nvim-surround").setup({})
  end,
}
