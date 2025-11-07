-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.lazyvim_mini_snippets_in_completion = true

vim.g.lazyvim_eslint_auto_format = true

-- enable django template lsp
vim.lsp.enable("djlsp")

--
-- WORD WRAP
--
vim.opt.breakindent = true -- Enable break indent
vim.opt.breakindentopt = "shift:2,min:40,sbr" -- Configure break indent
vim.opt.showbreak = "↪ " -- Visual indicator for wrapped lines
-- vim.opt.wrap = false -- Visually wrap long lines
-- vim.opt.linebreak = true -- Break at word boundaries
-- vim.opt.breakindent = true -- Keep wrapped lines visually indented
-- vim.opt.textwidth = 80 -- Hard-wrap lines at 80 chars
-- vim.opt.formatoptions:append("t") -- Enable auto-wrap when typing
