-- Fallback theme for non-Omarchy systems; Omarchy's theme.lua loads later and overrides it.
return {
  { "rose-pine/neovim" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "rose-pine",
    },
  },
}
