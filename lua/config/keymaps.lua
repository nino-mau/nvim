-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local ls = require("luasnip")
-- local supermavenSuggestion = require("supermaven-nvim.completion_preview")

-- Run java file
map("n", "<leader>jR", function()
  local file = vim.fn.expand("%:p")
  -- Run java without invoking a shell to avoid shell header output
  local lines = vim.fn.systemlist({ "java", file }) -- captures output as list of lines
  -- Strip ANSI escape sequences and trim whitespace from each line
  for i, l in ipairs(lines) do
    l = l:gsub("\27%[[0-9;]*m", "")
    l = l:gsub("^%s*(.-)%s*$", "%1")
    lines[i] = l
  end
  local err = vim.v.shell_error
  local out_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_name(out_buf, "Java: " .. vim.fn.expand("%:t"))
  vim.api.nvim_buf_set_lines(out_buf, 0, -1, false, lines)
  vim.api.nvim_open_win(out_buf, true, {
    relative = "editor",
    width = math.min(80, vim.o.columns - 10),
    height = math.min(20, vim.o.lines - 10),
    row = 2,
    col = 4,
    style = "minimal",
    border = "single",
  })
end, { desc = "Run current Java file and show output (sync)" })

-- Various utilities keybindings
--

-- In normal mode, <C-c> will select all lines and yank into the system clipboard:
map("n", "<C-c>", ":%y<CR>", { noremap = true, silent = true, desc = "Copy entire buffer to system clipboard" })

-- Tab to go to next buffer
map("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Next buffer" })

-- Shift-Tab to go to previous buffer
map("n", "<S-Tab>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })

-- Delete word under cursor
map("n", "<C-BS>", "<C-\\><C-O>daw", { desc = "Delete word" })

-- Copy word under cursor
map("n", "yw", "yiw", { desc = "Copy word under cursor" })

-- Del word under cursor
map("n", "<C-x>", "diw", { desc = "Delete word under cursor" })

-- Edit word under cursor
map("n", "cw", "ciw", { desc = "Edit word under cursor" })

--
-- Various plugins related keybindings
--

-- Keybind to trigger inc rename
map("n", "<leader>rn", ":IncRename ")

-- Remap luansip key to jump between snippets node
map({ "i", "s" }, "<C-D>", function()
  ls.jump(1)
end, { silent = true })
map({ "i", "s" }, "<C-G>", function()
  ls.jump(-1)
end, { silent = true })

-- Keybind to activate/deactivate supermaven auto completion
-- map("n", "<leader>ac", function()
--   if supermavenSuggestion.disable_inline_completion then
--     supermavenSuggestion.disable_inline_completion = false
--     print("Inline AI autocompletion ENABLED")
--   else
--     supermavenSuggestion.disable_inline_completion = true
--     print("Inline AI autocompletion DISABLED")
--   end
-- end, { desc = "Toggle inline completion" })
--
-- map("i", "<C-c>", function()
--   if supermavenSuggestion.disable_inline_completion then
--     supermavenSuggestion.disable_inline_completion = false
--     print("Inline AI autocompletion ENABLED")
--   else
--     supermavenSuggestion.disable_inline_completion = true
--     print("Inline AI autocompletion DISABLED")
--   end
-- end, { desc = "Toggle inline completion" })

-- Bootstrap 5.3 utilities picker (Snacks)
map("n", "<leader>fb", function()
  local function items_from(category, defs)
    local res = {}
    for _, d in ipairs(defs) do
      local class = d[1]
      local desc = d[2]
      table.insert(res, {
        -- keep label for display & insertion; use text for matching (includes desc + category)
        label = class,
        text = table.concat({ class, desc or "", "[" .. category .. "]" }, " "),
        category = category,
        description = desc,
        preview = {
          ft = "markdown",
          text = table.concat({
            "# " .. class,
            "",
            "Category: " .. category,
            "",
            desc,
            "",
            "Docs: https://getbootstrap.com/docs/5.3/utilities/",
          }, "\n"),
        },
      })
    end
    return res
  end

  local items = {}

  -- Display
  vim.list_extend(
    items,
    items_from("Display", {
      { "d-none", "Hide element (display: none)" },
      { "d-inline", "Inline element" },
      { "d-inline-block", "Inline-block element" },
      { "d-block", "Block element" },
      { "d-grid", "CSS Grid container" },
      { "d-inline-grid", "Inline grid container" },
      { "d-flex", "Flex container" },
      { "d-inline-flex", "Inline flex container" },
      { "d-table", "Table display" },
      { "d-table-row", "Table row display" },
      { "d-table-cell", "Table cell display" },
    })
  )

  -- Flexbox
  vim.list_extend(
    items,
    items_from("Flex", {
      { "flex-row", "Flex direction row" },
      { "flex-column", "Flex direction column" },
      { "flex-row-reverse", "Reverse row" },
      { "flex-column-reverse", "Reverse column" },
      { "justify-content-start", "Align items at start on main axis" },
      { "justify-content-center", "Center items on main axis" },
      { "justify-content-between", "Space between on main axis" },
      { "justify-content-around", "Space around on main axis" },
      { "justify-content-evenly", "Space evenly on main axis" },
      { "align-items-start", "Align items at start on cross axis" },
      { "align-items-center", "Center items on cross axis" },
      { "align-items-end", "Align items at end on cross axis" },
      { "align-self-start", "Self align start" },
      { "align-self-center", "Self align center" },
      { "align-self-end", "Self align end" },
      { "flex-wrap", "Allow wrap" },
      { "flex-nowrap", "No wrap" },
      { "flex-wrap-reverse", "Reverse wrap" },
      { "order-0", "Flex order 0" },
      { "order-1", "Flex order 1" },
      { "order-2", "Flex order 2" },
      { "order-3", "Flex order 3" },
      { "order-first", "Flex first (-1)" },
      { "order-last", "Flex last (6)" },
      { "flex-fill", "Make items fill equally" },
      { "flex-grow-1", "Allow to grow" },
      { "flex-shrink-1", "Allow to shrink" },
      { "flex-grow-0", "Prevent growing" },
      { "flex-shrink-0", "Prevent shrinking" },
    })
  )

  -- Spacing
  vim.list_extend(
    items,
    items_from("Spacing", {
      { "m-0", "Margin 0" },
      { "m-1", "Margin spacer * .25" },
      { "m-2", "Margin spacer * .5" },
      { "m-3", "Margin spacer" },
      { "m-4", "Margin spacer * 1.5" },
      { "m-5", "Margin spacer * 3" },
      { "mt-3", "Margin top spacer" },
      { "mb-3", "Margin bottom spacer" },
      { "ms-3", "Margin start spacer" },
      { "me-3", "Margin end spacer" },
      { "mx-auto", "Horizontal auto margins (center block)" },
      { "p-0", "Padding 0" },
      { "p-1", "Padding spacer * .25" },
      { "p-2", "Padding spacer * .5" },
      { "p-3", "Padding spacer" },
      { "px-4", "Horizontal padding * 1.5" },
      { "py-2", "Vertical padding * .5" },
      { "gap-2", "Gap 2 (grid/flex)" },
      { "row-gap-3", "Row gap 3" },
      { "column-gap-3", "Column gap 3" },
    })
  )

  -- Text
  vim.list_extend(
    items,
    items_from("Text", {
      { "text-start", "Left/start text alignment" },
      { "text-center", "Center text" },
      { "text-end", "Right/end text alignment" },
      { "text-wrap", "Wrap long words" },
      { "text-nowrap", "Prevent wrapping" },
      { "text-break", "Break long words" },
      { "fw-bold", "Bold font weight" },
      { "fw-semibold", "Semibold font weight" },
      { "fst-italic", "Italic font style" },
      { "lh-1", "Line-height 1" },
      { "lh-sm", "Small line-height" },
      { "lh-base", "Base line-height" },
      { "lh-lg", "Large line-height" },
    })
  )

  -- Colors & Background
  vim.list_extend(
    items,
    items_from("Colors", {
      { "text-primary", "Primary text color" },
      { "text-secondary", "Secondary text color" },
      { "text-success", "Success text color" },
      { "text-danger", "Danger text color" },
      { "text-warning", "Warning text color" },
      { "text-info", "Info text color" },
      { "text-light", "Light text color" },
      { "text-dark", "Dark text color" },
      { "text-body", "Body text color" },
      { "text-muted", "Muted text color" },
    })
  )
  vim.list_extend(
    items,
    items_from("Background", {
      { "bg-primary", "Primary background" },
      { "bg-secondary", "Secondary background" },
      { "bg-success", "Success background" },
      { "bg-danger", "Danger background" },
      { "bg-warning", "Warning background" },
      { "bg-info", "Info background" },
      { "bg-light", "Light background" },
      { "bg-dark", "Dark background" },
      { "bg-transparent", "Transparent background" },
    })
  )

  -- Borders & Radius
  vim.list_extend(
    items,
    items_from("Borders", {
      { "border", "Add border" },
      { "border-0", "Remove all borders" },
      { "border-top", "Add top border" },
      { "border-bottom", "Add bottom border" },
      { "border-start", "Add start/left border" },
      { "border-end", "Add end/right border" },
      { "border-primary", "Primary border color" },
      { "border-1", "Border width 1" },
      { "border-2", "Border width 2" },
    })
  )
  vim.list_extend(
    items,
    items_from("Radius", {
      { "rounded", "Rounded corners" },
      { "rounded-0", "No rounding" },
      { "rounded-1", "Small radius" },
      { "rounded-2", "Medium radius" },
      { "rounded-3", "Large radius" },
      { "rounded-circle", "Full circle radius" },
      { "rounded-pill", "Pill radius" },
    })
  )

  -- Sizing
  vim.list_extend(
    items,
    items_from("Sizing", {
      { "w-25", "Width 25%" },
      { "w-50", "Width 50%" },
      { "w-75", "Width 75%" },
      { "w-100", "Width 100%" },
      { "w-auto", "Auto width" },
      { "h-25", "Height 25%" },
      { "h-50", "Height 50%" },
      { "h-75", "Height 75%" },
      { "h-100", "Height 100%" },
      { "h-auto", "Auto height" },
      { "min-vw-100", "Min viewport width 100%" },
      { "min-vh-100", "Min viewport height 100%" },
    })
  )

  -- Position
  vim.list_extend(
    items,
    items_from("Position", {
      { "position-static", "Static positioning" },
      { "position-relative", "Relative positioning" },
      { "position-absolute", "Absolute positioning" },
      { "position-fixed", "Fixed positioning" },
      { "position-sticky", "Sticky positioning" },
      { "top-0", "Top 0" },
      { "bottom-0", "Bottom 0" },
      { "start-0", "Start/left 0" },
      { "end-0", "End/right 0" },
      { "translate-middle", "Translate -50%/-50%" },
    })
  )

  -- Effects / misc
  vim.list_extend(
    items,
    items_from("Shadows & Effects", {
      { "shadow", "Regular box shadow" },
      { "shadow-sm", "Small shadow" },
      { "shadow-lg", "Large shadow" },
      { "shadow-none", "No shadow" },
      { "opacity-50", "50% opacity" },
      { "opacity-100", "100% opacity" },
      { "overflow-auto", "Add scrollbars as needed" },
      { "overflow-hidden", "Hide overflowing content" },
      { "overflow-visible", "Show overflowing content" },
      { "overflow-scroll", "Always show scrollbars" },
      { "visible", "Visibility: visible" },
      { "invisible", "Visibility: hidden" },
      { "z-3", "z-index 3" },
      { "z-2", "z-index 2" },
      { "z-1", "z-index 1" },
      { "z-0", "z-index 0" },
      { "z-n1", "z-index -1" },
    })
  )

  -- Object fit / Float / Vertical align
  vim.list_extend(
    items,
    items_from("Object fit", {
      { "object-fit-contain", "Contain within content box" },
      { "object-fit-cover", "Cover content box" },
      { "object-fit-fill", "Stretch to fill" },
      { "object-fit-scale", "Scale down" },
      { "object-fit-none", "No resizing" },
    })
  )
  vim.list_extend(
    items,
    items_from("Float", {
      { "float-start", "Float to start/left" },
      { "float-end", "Float to end/right" },
      { "float-none", "No float" },
      { "clearfix", "Clear floated content (helper)" },
    })
  )
  vim.list_extend(
    items,
    items_from("Vertical align", {
      { "align-baseline", "Vertical-align: baseline" },
      { "align-top", "Vertical-align: top" },
      { "align-middle", "Vertical-align: middle" },
      { "align-bottom", "Vertical-align: bottom" },
      { "align-text-bottom", "Vertical-align: text-bottom" },
      { "align-text-top", "Vertical-align: text-top" },
    })
  )

  -- Build a custom formatter to show class and description in one line
  local function fmt(item)
    return {
      { item.label or item.text },
      { "  —  ", "Comment" },
      { item.description or "", "Comment" },
      { "  [" .. (item.category or "") .. "]", "Comment" },
    }
  end

  -- custom action to filter by the category of the current item
  local function filter_by_category_action(picker)
    local cur = picker:current({ resolve = false })
    if not cur or not cur.category then
      return
    end
    local cat = cur.category
    local all = picker.init_opts and picker.init_opts._all_items or {}
    local filtered = {}
    for _, it in ipairs(all) do
      if it.category == cat then
        table.insert(filtered, it)
      end
    end
    picker:close()
    Snacks.picker.pick({
      title = "Bootstrap 5.3 Utilities — " .. cat,
      items = filtered,
      format = fmt,
      preview = "preview",
      layout = { preset = "vertical" },
      _all_items = all,
      actions = { filter_by_category = filter_by_category_action },
      confirm = function(p, item)
        if not item then
          return
        end
        p:close()
        local row, col = unpack(vim.api.nvim_win_get_cursor(0))
        local val = item.label or item.text
        vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, { val })
        vim.api.nvim_win_set_cursor(0, { row, col + #val })
      end,
      win = {
        input = {
          keys = {
            ["<A-c>"] = { "filter_by_category", mode = { "n", "i" }, desc = "Filter by Category" },
          },
        },
        list = {
          keys = {
            ["<A-c>"] = { "filter_by_category", desc = "Filter by Category" },
          },
        },
      },
    })
  end

  Snacks.picker.pick({
    title = "Bootstrap 5.3 Utilities",
    items = items,
    format = fmt,
    preview = "preview",
    layout = { preset = "vertical" },
    _all_items = items,
    actions = { filter_by_category = filter_by_category_action },
    confirm = function(picker, item)
      if not item then
        return
      end
      picker:close()
      local row, col = unpack(vim.api.nvim_win_get_cursor(0))
      local val = item.label or item.text
      vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, { val })
      vim.api.nvim_win_set_cursor(0, { row, col + #val })
    end,
    win = {
      input = {
        keys = {
          ["<A-c>"] = { "filter_by_category", mode = { "n", "i" }, desc = "Filter by Category" },
        },
      },
      list = {
        keys = {
          ["<A-c>"] = { "filter_by_category", desc = "Filter by Category" },
        },
      },
    },
  })
end, { desc = "Find Bootstrap classes" })

-- Category-first flow: pick a category, then a class within it
map("n", "<leader>fB", function()
  -- Helper to build all bootstrap items
  local function build_items()
    local function items_from(category, defs)
      local res = {}
      for _, d in ipairs(defs) do
        local class = d[1]
        local desc = d[2]
        table.insert(res, {
          label = class,
          text = table.concat({ class, desc or "", "[" .. category .. "]" }, " "),
          category = category,
          description = desc,
          preview = {
            ft = "markdown",
            text = table.concat({
              "# " .. class,
              "",
              "Category: " .. category,
              "",
              desc,
              "",
              "Docs: https://getbootstrap.com/docs/5.3/utilities/",
            }, "\n"),
          },
        })
      end
      return res
    end

    local items = {}
    vim.list_extend(
      items,
      items_from("Display", {
        { "d-none", "Hide element (display: none)" },
        { "d-inline", "Inline element" },
        { "d-inline-block", "Inline-block element" },
        { "d-block", "Block element" },
        { "d-grid", "CSS Grid container" },
        { "d-inline-grid", "Inline grid container" },
        { "d-flex", "Flex container" },
        { "d-inline-flex", "Inline flex container" },
        { "d-table", "Table display" },
        { "d-table-row", "Table row display" },
        { "d-table-cell", "Table cell display" },
      })
    )
    vim.list_extend(
      items,
      items_from("Flex", {
        { "flex-row", "Flex direction row" },
        { "flex-column", "Flex direction column" },
        { "flex-row-reverse", "Reverse row" },
        { "flex-column-reverse", "Reverse column" },
        { "justify-content-start", "Align items at start on main axis" },
        { "justify-content-center", "Center items on main axis" },
        { "justify-content-between", "Space between on main axis" },
        { "justify-content-around", "Space around on main axis" },
        { "justify-content-evenly", "Space evenly on main axis" },
        { "align-items-start", "Align items at start on cross axis" },
        { "align-items-center", "Center items on cross axis" },
        { "align-items-end", "Align items at end on cross axis" },
        { "align-self-start", "Self align start" },
        { "align-self-center", "Self align center" },
        { "align-self-end", "Self align end" },
        { "flex-wrap", "Allow wrap" },
        { "flex-nowrap", "No wrap" },
        { "flex-wrap-reverse", "Reverse wrap" },
        { "order-0", "Flex order 0" },
        { "order-1", "Flex order 1" },
        { "order-2", "Flex order 2" },
        { "order-3", "Flex order 3" },
        { "order-first", "Flex first (-1)" },
        { "order-last", "Flex last (6)" },
        { "flex-fill", "Make items fill equally" },
        { "flex-grow-1", "Allow to grow" },
        { "flex-shrink-1", "Allow to shrink" },
        { "flex-grow-0", "Prevent growing" },
        { "flex-shrink-0", "Prevent shrinking" },
      })
    )
    vim.list_extend(
      items,
      items_from("Spacing", {
        { "m-0", "Margin 0" },
        { "m-1", "Margin spacer * .25" },
        { "m-2", "Margin spacer * .5" },
        { "m-3", "Margin spacer" },
        { "m-4", "Margin spacer * 1.5" },
        { "m-5", "Margin spacer * 3" },
        { "mt-3", "Margin top spacer" },
        { "mb-3", "Margin bottom spacer" },
        { "ms-3", "Margin start spacer" },
        { "me-3", "Margin end spacer" },
        { "mx-auto", "Horizontal auto margins (center block)" },
        { "p-0", "Padding 0" },
        { "p-1", "Padding spacer * .25" },
        { "p-2", "Padding spacer * .5" },
        { "p-3", "Padding spacer" },
        { "px-4", "Horizontal padding * 1.5" },
        { "py-2", "Vertical padding * .5" },
        { "gap-2", "Gap 2 (grid/flex)" },
        { "row-gap-3", "Row gap 3" },
        { "column-gap-3", "Column gap 3" },
      })
    )
    vim.list_extend(
      items,
      items_from("Text", {
        { "text-start", "Left/start text alignment" },
        { "text-center", "Center text" },
        { "text-end", "Right/end text alignment" },
        { "text-wrap", "Wrap long words" },
        { "text-nowrap", "Prevent wrapping" },
        { "text-break", "Break long words" },
        { "fw-bold", "Bold font weight" },
        { "fw-semibold", "Semibold font weight" },
        { "fst-italic", "Italic font style" },
        { "lh-1", "Line-height 1" },
        { "lh-sm", "Small line-height" },
        { "lh-base", "Base line-height" },
        { "lh-lg", "Large line-height" },
      })
    )
    vim.list_extend(
      items,
      items_from("Colors", {
        { "text-primary", "Primary text color" },
        { "text-secondary", "Secondary text color" },
        { "text-success", "Success text color" },
        { "text-danger", "Danger text color" },
        { "text-warning", "Warning text color" },
        { "text-info", "Info text color" },
        { "text-light", "Light text color" },
        { "text-dark", "Dark text color" },
        { "text-body", "Body text color" },
        { "text-muted", "Muted text color" },
      })
    )
    vim.list_extend(
      items,
      items_from("Background", {
        { "bg-primary", "Primary background" },
        { "bg-secondary", "Secondary background" },
        { "bg-success", "Success background" },
        { "bg-danger", "Danger background" },
        { "bg-warning", "Warning background" },
        { "bg-info", "Info background" },
        { "bg-light", "Light background" },
        { "bg-dark", "Dark background" },
        { "bg-transparent", "Transparent background" },
      })
    )
    vim.list_extend(
      items,
      items_from("Borders", {
        { "border", "Add border" },
        { "border-0", "Remove all borders" },
        { "border-top", "Add top border" },
        { "border-bottom", "Add bottom border" },
        { "border-start", "Add start/left border" },
        { "border-end", "Add end/right border" },
        { "border-primary", "Primary border color" },
        { "border-1", "Border width 1" },
        { "border-2", "Border width 2" },
      })
    )
    vim.list_extend(
      items,
      items_from("Radius", {
        { "rounded", "Rounded corners" },
        { "rounded-0", "No rounding" },
        { "rounded-1", "Small radius" },
        { "rounded-2", "Medium radius" },
        { "rounded-3", "Large radius" },
        { "rounded-circle", "Full circle radius" },
        { "rounded-pill", "Pill radius" },
      })
    )
    vim.list_extend(
      items,
      items_from("Sizing", {
        { "w-25", "Width 25%" },
        { "w-50", "Width 50%" },
        { "w-75", "Width 75%" },
        { "w-100", "Width 100%" },
        { "w-auto", "Auto width" },
        { "h-25", "Height 25%" },
        { "h-50", "Height 50%" },
        { "h-75", "Height 75%" },
        { "h-100", "Height 100%" },
        { "h-auto", "Auto height" },
        { "min-vw-100", "Min viewport width 100%" },
        { "min-vh-100", "Min viewport height 100%" },
      })
    )
    vim.list_extend(
      items,
      items_from("Position", {
        { "position-static", "Static positioning" },
        { "position-relative", "Relative positioning" },
        { "position-absolute", "Absolute positioning" },
        { "position-fixed", "Fixed positioning" },
        { "position-sticky", "Sticky positioning" },
        { "top-0", "Top 0" },
        { "bottom-0", "Bottom 0" },
        { "start-0", "Start/left 0" },
        { "end-0", "End/right 0" },
        { "translate-middle", "Translate -50%/-50%" },
      })
    )
    vim.list_extend(
      items,
      items_from("Shadows & Effects", {
        { "shadow", "Regular box shadow" },
        { "shadow-sm", "Small shadow" },
        { "shadow-lg", "Large shadow" },
        { "shadow-none", "No shadow" },
        { "opacity-50", "50% opacity" },
        { "opacity-100", "100% opacity" },
        { "overflow-auto", "Add scrollbars as needed" },
        { "overflow-hidden", "Hide overflowing content" },
        { "overflow-visible", "Show overflowing content" },
        { "overflow-scroll", "Always show scrollbars" },
        { "visible", "Visibility: visible" },
        { "invisible", "Visibility: hidden" },
        { "z-3", "z-index 3" },
        { "z-2", "z-index 2" },
        { "z-1", "z-index 1" },
        { "z-0", "z-index 0" },
        { "z-n1", "z-index -1" },
      })
    )
    vim.list_extend(
      items,
      items_from("Object fit", {
        { "object-fit-contain", "Contain within content box" },
        { "object-fit-cover", "Cover content box" },
        { "object-fit-fill", "Stretch to fill" },
        { "object-fit-scale", "Scale down" },
        { "object-fit-none", "No resizing" },
      })
    )
    vim.list_extend(
      items,
      items_from("Float", {
        { "float-start", "Float to start/left" },
        { "float-end", "Float to end/right" },
        { "float-none", "No float" },
        { "clearfix", "Clear floated content (helper)" },
      })
    )
    vim.list_extend(
      items,
      items_from("Vertical align", {
        { "align-baseline", "Vertical-align: baseline" },
        { "align-top", "Vertical-align: top" },
        { "align-middle", "Vertical-align: middle" },
        { "align-bottom", "Vertical-align: bottom" },
        { "align-text-bottom", "Vertical-align: text-bottom" },
        { "align-text-top", "Vertical-align: text-top" },
      })
    )
    return items
  end

  -- Action to filter by the current item's category
  local function filter_by_category_action(picker)
    local cur = picker:current({ resolve = false })
    if not cur or not cur.category then
      return
    end
    local cat = cur.category
    local all = picker.init_opts and picker.init_opts._all_items or {}
    local filtered = {}
    for _, it in ipairs(all) do
      if it.category == cat then
        table.insert(filtered, it)
      end
    end
    picker:close()
    Snacks.picker.pick({
      title = "Bootstrap 5.3 Utilities — " .. cat,
      items = filtered,
      format = function(item)
        return {
          { item.label or item.text },
          { "  —  ", "Comment" },
          { item.description or "", "Comment" },
          { "  [" .. (item.category or "") .. "]", "Comment" },
        }
      end,
      preview = "preview",
      layout = { preset = "vertical" },
      _all_items = all,
      actions = { filter_by_category = filter_by_category_action },
      confirm = function(p, item)
        if not item then
          return
        end
        p:close()
        local row, col = unpack(vim.api.nvim_win_get_cursor(0))
        local val = item.label or item.text
        vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, { val })
        vim.api.nvim_win_set_cursor(0, { row, col + #val })
      end,
      win = {
        input = {
          keys = {
            ["<A-c>"] = { "filter_by_category", mode = { "n", "i" }, desc = "Filter by Category" },
          },
        },
        list = {
          keys = {
            ["<A-c>"] = { "filter_by_category", desc = "Filter by Category" },
          },
        },
      },
    })
  end

  -- Forward declare so actions can call it
  local open_categories

  -- Open the filtered picker for a chosen category
  local function open_filtered(chosen)
    local items = build_items()
    local filtered = {}
    for _, it in ipairs(items) do
      if it.category == chosen then
        table.insert(filtered, it)
      end
    end

    local function fmt(item)
      return {
        { item.label or item.text },
        { "  —  ", "Comment" },
        { item.description or "", "Comment" },
        { "  [" .. (item.category or "") .. "]", "Comment" },
      }
    end

    local function back_to_categories(p)
      p:close()
      open_categories()
    end

    Snacks.picker.pick({
      title = "Bootstrap 5.3 Utilities — " .. chosen,
      items = filtered,
      format = fmt,
      preview = "preview",
      layout = { preset = "vertical" },
      _all_items = items,
      actions = {
        filter_by_category = filter_by_category_action,
        back_to_categories = back_to_categories,
      },
      confirm = function(p, it)
        if not it then
          return
        end
        p:close()
        local row, col = unpack(vim.api.nvim_win_get_cursor(0))
        local val = it.label or it.text
        vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, { val })
        vim.api.nvim_win_set_cursor(0, { row, col + #val })
      end,
      win = {
        input = {
          keys = {
            ["<A-c>"] = { "filter_by_category", mode = { "n", "i" }, desc = "Filter by Category" },
            ["<Esc>"] = { "back_to_categories", mode = { "n", "i" }, desc = "Back to Categories" },
          },
        },
        list = {
          keys = {
            ["<A-c>"] = { "filter_by_category", desc = "Filter by Category" },
            ["<Esc>"] = { "back_to_categories", desc = "Back to Categories" },
          },
        },
      },
    })
  end

  -- Open the categories picker
  open_categories = function()
    local categories = {
      "Display",
      "Flex",
      "Spacing",
      "Text",
      "Colors",
      "Background",
      "Borders",
      "Radius",
      "Sizing",
      "Position",
      "Shadows & Effects",
      "Object fit",
      "Float",
      "Vertical align",
    }
    local cat_items = {}
    for _, c in ipairs(categories) do
      table.insert(cat_items, { text = c })
    end
    Snacks.picker.pick({
      title = "Bootstrap Utilities — Categories",
      items = cat_items,
      format = "text",
      preview = "none",
      layout = { preset = "select" },
      confirm = function(_, item)
        if not item then
          return
        end
        open_filtered(item.text)
      end,
    })
  end

  open_categories()
end, { desc = "Find Bootstrap classes by Category" })
