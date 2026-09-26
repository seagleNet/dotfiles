-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

require("config.remote_clipboard").setup()

LazyVim.terminal.setup(vim.fn.executable("fish") == 1 and "fish" or "bash")

vim.g.snacks_animate = false

vim.o.tabstop = 4
vim.o.shiftwidth = 4
