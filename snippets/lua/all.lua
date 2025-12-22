-- Snippets available in ALL filetypes
-- File must be named after the filetype (global.lua = all filetypes)

local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local i = ls.insert_node
local d = ls.dynamic_node
local f = ls.function_node

local function uuid()
  local id, _ = vim.fn.system("uuidgen -7"):gsub("\n", "")
  return id
end

function rand()
  local id, _ = vim.fn.system("rand"):gsub("\n", "")
  return id
end

return {
  s({
    trig = "uuid",
    name = "UUID",
    dscr = "Generate a unique UUID",
  }, {
    f(function()
      return uuid()
    end),
  }),

  s({
    trig = "rand",
    name = "Rand",
    dscr = "Generate a unique string using openssl",
  }, {
    f(function()
      return rand()
    end),
  }),
}
