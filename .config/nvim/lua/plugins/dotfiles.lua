-- Git integration for the dotfiles: a bare repo in ~/.dotfiles with $HOME as
-- work tree, which git tools don't find on their own (see ~/.local/bin/dot).
local gitdir = os.getenv("HOME") .. "/.dotfiles"

return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      -- tried only when a file isn't in a normal repo; untracked files in ~
      -- stay unsigned (attach_to_untracked is off)
      worktrees = {
        { toplevel = os.getenv("HOME"), gitdir = gitdir },
      },
    },
  },
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>g.",
        function()
          Snacks.lazygit({ args = { "--git-dir=" .. gitdir, "--work-tree=" .. os.getenv("HOME") } })
        end,
        desc = "Lazygit (dotfiles)",
      },
    },
  },
}
