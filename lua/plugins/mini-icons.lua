return {
  "nvim-mini/mini.icons",
  lazy = true,
  opts = {
    file = {
      [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
      ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
    },
    filetype = {
      dotenv = { glyph = "", hl = "MiniIconsYellow" },
    },
    lsp = {
      array = { glyph = "", hl = "MiniIconsOrange" },
      boolean = { glyph = "", hl = "MiniIconsOrange" },
      class = { glyph = "", hl = "MiniIconsPurple" },
      color = { glyph = "", hl = "MiniIconsRed" },
      constant = { glyph = "", hl = "MiniIconsOrange" },
      constructor = { glyph = "", hl = "MiniIconsAzure" },
      enum = { glyph = "", hl = "MiniIconsPurple" },
      enummember = { glyph = "", hl = "MiniIconsYellow" },
      event = { glyph = "", hl = "MiniIconsRed" },
      field = { glyph = "", hl = "MiniIconsYellow" },
      file = { glyph = "", hl = "MiniIconsBlue" },
      folder = { glyph = "", hl = "MiniIconsBlue" },
      ["function"] = { glyph = "󰊕", hl = "MiniIconsAzure" },
      interface = { glyph = "", hl = "MiniIconsPurple" },
      key = { glyph = "", hl = "MiniIconsYellow" },
      keyword = { glyph = "", hl = "MiniIconsCyan" },
      method = { glyph = "", hl = "MiniIconsAzure" },
      module = { glyph = "", hl = "MiniIconsPurple" },
      namespace = { glyph = "", hl = "MiniIconsRed" },
      null = { glyph = "", hl = "MiniIconsGrey" },
      number = { glyph = "", hl = "MiniIconsOrange" },
      object = { glyph = "", hl = "MiniIconsGrey" },
      operator = { glyph = "", hl = "MiniIconsCyan" },
      package = { glyph = "", hl = "MiniIconsPurple" },
      property = { glyph = "", hl = "MiniIconsYellow" },
      reference = { glyph = "", hl = "MiniIconsCyan" },
      snippet = { glyph = "", hl = "MiniIconsGreen" },
      Snippet = { glyph = "", hl = "MiniIconsGreen" },
      string = { glyph = "", hl = "MiniIconsGreen" },
      struct = { glyph = "", hl = "MiniIconsPurple" },
      text = { glyph = "", hl = "MiniIconsGreen" },
      typeparameter = { glyph = "", hl = "MiniIconsCyan" },
      unit = { glyph = "", hl = "MiniIconsCyan" },
      value = { glyph = "", hl = "MiniIconsBlue" },
      variable = { glyph = "", hl = "MiniIconsCyan" },
    },
  },
  init = function()
    package.preload["nvim-web-devicons"] = function()
      require("mini.icons").mock_nvim_web_devicons()
      return package.loaded["nvim-web-devicons"]
    end
  end,
}
