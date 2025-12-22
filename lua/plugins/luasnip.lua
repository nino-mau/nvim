-- add nvim-luasnip
return {
  {
    "L3MON4D3/LuaSnip",
    version = "*", -- or a specific tag/commit
    event = "InsertEnter", -- lazy-load on insert
    dependencies = {
      "rafamadriz/friendly-snippets", -- optional collection
    },
    config = function()
      local ls = require("luasnip")

      local s, sn = ls.snippet, ls.snippet_node
      local i, d = ls.insert_node, ls.dynamic_node

      ls.filetype_extend("vue", { "typescript" })

      ls.config.setup({
        history = true,
        updateevents = "TextChanged,TextChangedI",
      })

      local function uuid()
        local id, _ = vim.fn.system("uuidgen -7"):gsub("\n", "")
        return id
      end

      -- Custom uuid snippet
      ls.add_snippets("global", {
        s({
          trig = "uuid",
          name = "UUID",
          dscr = "Generate a unique UUID",
        }, {
          d(1, function()
            return sn(nil, i(1, uuid()))
          end),
        }),
      })
    end,
    opts = function()
      local ls = require("luasnip")
      -- load VSCode-style snippets
      require("luasnip.loaders.from_vscode").lazy_load({ paths = "~/.config/nvim/snippets/vscode/" })
      return ls
    end,
  },
}
