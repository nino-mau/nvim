return {
  {
    "L3MON4D3/LuaSnip",
    version = "*",
    event = "InsertEnter",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local ls = require("luasnip")

      ls.filetype_extend("vue", { "typescript" })

      ls.config.setup({
        history = true,
        updateevents = "TextChanged,TextChangedI",
      })

      -- Load VSCode-style snippets
      require("luasnip.loaders.from_vscode").lazy_load({ paths = "~/.config/nvim/snippets/vscode/" })

      -- Load Lua snippets (e.g., snippets/global.lua for all filetypes)
      require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/snippets/lua/" })
    end,
  },
}
