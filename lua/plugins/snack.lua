return {
  "folke/snacks.nvim",
  opts = {
    dashboard = {
      enabled = true,
      preset = {
        pick = nil,
        ---@type snacks.dashboard.Item[]
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          {
            icon = " ",
            key = "c",
            desc = "Config",
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
        header = [[
                                                                                      
               ████ ██████           █████      ██                              
              ███████████             █████                                      
              █████████ ███████████████████ ███   ███████████            
             █████████  ███    █████████████ █████ ██████████████            
            █████████ ██████████ █████████ █████ █████ ████ █████            
          ███████████ ███    ███ █████████ █████ █████ ████ █████           
         ██████  █████████████████████ ████ █████ █████ ████ ██████          
      ]],
      },
      styles = {
        header = {
          fg = "#7686C2",
        },
      },
      sections = {
        { section = "header", align = "center" },
        {
          section = "keys",
          indent = 1,
          gap = 1,
          padding = 3,
        },
        {
          section = "terminal",
          cmd = "sh ~/.local/share/colorscripts/square; sleep .1",
          height = 8,
          padding = 1,
          align = "center",
        },
      },
    },
    picker = {
      exclude = {
        "node_modules",
        -- ".nuxt/dev",
        -- ".nuxt/dist",
        ".nuxt/ui",
        ".next",
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
