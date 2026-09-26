-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

if vim.fn.executable("fish") == 1 then
  LazyVim.terminal.setup("fish")
else
  LazyVim.terminal.setup("bash")
end

vim.g.snacks_animate = false

vim.o.tabstop = 4
vim.o.shiftwidth = 4
