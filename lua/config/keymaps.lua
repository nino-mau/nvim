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
-- Expand lua snippet
map({ "i", "s" }, "<C-j>", function()
  if ls.expandable() then
    ls.expand()
  end
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
