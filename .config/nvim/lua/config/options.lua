-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

require("config.remote_clipboard").setup()

LazyVim.terminal.setup(vim.fn.executable("fish") == 1 and "fish" or "bash")

vim.g.snacks_animate = false

vim.o.tabstop = 4
vim.o.shiftwidth = 4

-- Ghostty already sends 3 wheel events per click; scroll 1 line per event there.
-- Other terminals (e.g. Windows Terminal in WSL) keep the default ver:3.
if vim.env.TERM_PROGRAM == "ghostty" or (vim.env.TERM or ""):find("ghostty") then
  vim.o.mousescroll = "ver:1,hor:2"
end
