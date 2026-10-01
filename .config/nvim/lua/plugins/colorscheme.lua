-- Fallback theme for non-Omarchy systems; Omarchy's theme.lua loads later and overrides it.
return {
  -- same name as Omarchy's all-themes.lua, so lazy-lock.json agrees on every machine
  { "rose-pine/neovim", name = "rose-pine" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "rose-pine",
    },
  },
}
