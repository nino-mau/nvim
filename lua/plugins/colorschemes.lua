return {
  {
    "nino-mau/poimandres.nvim",
    name = "poimandres",
    lazy = false,
    priority = 1000,
    config = function()
      require("poimandres").setup({
        bold_vert_split = false, -- use bold vertical separators
        dim_nc_background = false, -- dim 'non-current' window backgrounds
        disable_background = true, -- disable background
        disable_float_background = true, -- disable background for floats
        disable_italics = false, -- disable italics
      })
    end,
  },
  { "projekt0n/github-nvim-theme", name = "github-theme" },
  { "shaunsingh/nord.nvim", name = "nord" },
}
