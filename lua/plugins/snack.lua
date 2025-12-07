return {
  "folke/snacks.nvim",
  opts = {
    dashboard = {
      enabled = true,
      preset = {
        pick = nil,
        ---@type snacks.dashboard.Item[]
        keys = {
          { icon = "", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = "󰦛", key = "s", desc = "Restore Session", section = "session" },
          { icon = "", key = "q", desc = "Quit", action = ":qa" },
        },
        header = [=[
                                         _.oo.
                 _.u[[/;:,.         .odMMMMMM'
              .o888UU[[[/;:-.  .o@P^    MMM^
             oN88888UU[[[/;::-.        dP^  
            dNMMNN888UU[[[/;:--.   .o@P^   
           ,MMMMMMN888UU[[/;::-. o@^       
           NNMMMNN888UU[[[/~.o@P^          
           888888888UU[[[/o@^-..           
          oI8888UU[[[/o@P^:--..            
       .@^  YUU[[[/o@^;::---..             
     oMP     ^/o@P^;:::---..               
  .dMMM    .o@^ ^;::---...                 
 dMMMMMMM@^`       `^^^^                   
YMMMUP^                                    
 ^^                                        
      ]=],
      },

      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        -- {
        --   pane = 2,
        --   icon = "󰊢 ",
        --   title = "Git Status",
        --   section = "terminal",
        --   enabled = function()
        --     return Snacks.git.get_root() ~= nil
        --   end,
        --   cmd = "git status --short --branch --renames",
        --   height = 5,
        --   padding = 1,
        --   ttl = 5 * 60,
        --   indent = 3,
        -- },
        function()
          local git_root = vim.fn.system("git rev-parse --show-toplevel 2>/dev/null"):gsub("\n", "")
          if vim.v.shell_error ~= 0 then
            -- Not in a git repo, show project list instead
            return {
              icon = "",
              title = "Recent Projects",
              section = "projects",
              padding = 1,
              indent = 3,
            }
          end
          local repo_name = vim.fn.fnamemodify(git_root, ":t")
          local branch = vim.fn.system("git branch --show-current 2>/dev/null"):gsub("\n", "")
          return {
            icon = "",
            title = repo_name .. " (" .. branch .. ")",
            section = "terminal",
            cmd = "git log --format='%C(auto)%s %C(dim)%C(reset)' --color=always -n 8",
            height = 10,
            padding = 1,
            gap = 1,
            indent = 3,
          }
        end,
        -- {
        --   section = "terminal",
        --   align = "center",
        --   width = 60,
        --   cmd = "sh ~/.local/share/colorscripts/circle; sleep .1",
        -- },
        -- { section = "startup" },
      },
    },

    picker = {
      exclude = {
        "node_modules",
        -- ".nuxt/dev",
        -- ".nuxt/dist",
        ".nuxt/ui",
        ".next",
        "dist",
        "jimu-ui",
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
    styles = {
      notification = {
        wo = { wrap = true }, -- Wrap notifications
      },
    },
  },
  config = function(_, opts)
    require("snacks").setup(opts)

    -- Function to set dashboard colors
    local function set_dashboard_colors()
      vim.api.nvim_set_hl(0, "SnacksDashboardHeader", { fg = "#8aadf4", bold = true })
      vim.api.nvim_set_hl(0, "SnacksDashboardIcon", { fg = "#8aadf4" })
      vim.api.nvim_set_hl(0, "SnacksDashboardKey", { fg = "#8aadf4" })
      vim.api.nvim_set_hl(0, "SnacksDashboardDesc", { fg = "#cad3f5" })
      vim.api.nvim_set_hl(0, "SnacksDashboardFooter", { fg = "#cad3f5" })
      vim.api.nvim_set_hl(0, "SnacksDashboardTitle", { fg = "#8aadf4", bold = true })
      vim.api.nvim_set_hl(0, "SnacksDashboardDir", { fg = "#a5adcb" }) -- Project path color
      vim.api.nvim_set_hl(0, "SnacksDashboardFile", { fg = "#bb9af7" }) -- Project name color
    end

    -- Function to set picker colors
    local function set_picker_colors()
      vim.api.nvim_set_hl(0, "SnacksPickerDir", { fg = "#565f89" }) -- Directory color in picker
      vim.api.nvim_set_hl(0, "SnacksPickerFile", { fg = "#cad3f5" }) -- File name color in picker
      vim.api.nvim_set_hl(0, "SnacksPickerMatch", { fg = "#bb9af7", bold = true }) -- Match highlight
      vim.api.nvim_set_hl(0, "SnacksPickerTitle", { fg = "#8aadf4", bold = true }) -- Picker title
      vim.api.nvim_set_hl(0, "SnacksPickerBorder", { fg = "#565f89" }) -- Picker border
      -- Explorer colors
      vim.api.nvim_set_hl(0, "SnacksIndent", { fg = "#565f89" }) -- Indent guides
      vim.api.nvim_set_hl(0, "SnacksIndentScope", { fg = "#8aadf4" }) -- Current scope indent
    end

    -- Set colors immediately
    set_dashboard_colors()
    set_picker_colors()

    -- Re-apply colors after colorscheme changes
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = function()
        set_dashboard_colors()
        set_picker_colors()
      end,
    })

    -- Re-apply colors when dashboard is shown or when buffers change
    vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
      pattern = "*",
      callback = function()
        set_dashboard_colors()
        set_picker_colors()
      end,
    })
  end,
}
