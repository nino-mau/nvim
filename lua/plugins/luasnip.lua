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
        local id, _ = vim.fn.system("uuidgen"):gsub("\n", "")
        return id
      end

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

      -- vim.keymap.set({ "i", "s" }, "<C-P>", function()
      --   if ls.expand_or_locally_jumpable() then
      --     ls.expand_or_jump()
      --   end
      -- end, { desc = "Expand or jump forward in lua-snippet", silent = true })
      --
      -- vim.keymap.set({ "i", "s" }, "<C-J>", function()
      --   if ls.jumpable(-1) then
      --     ls.jump(-1)
      --   end
      -- end, { desc = "Jump backward in lua-snippet", silent = true })

      -- Load custom snippets
    end,
    opts = function()
      local ls = require("luasnip")
      -- load VSCode-style snippets from friendly-snippets
      require("luasnip.loaders.from_vscode").lazy_load({ paths = "~/.config/lazyvim/snippets/vscode/" })
      return ls
    end,
  },
}
