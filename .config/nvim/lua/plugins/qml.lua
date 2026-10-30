return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "qmljs" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Arch ships it as qmlls6; it comes from Qt, not Mason.
        qmlls = { cmd = { "qmlls6" }, mason = false },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters = {
        -- Not on PATH on Arch. Picks up a .qmlformat.ini next to the file.
        qmlformat = { command = "/usr/lib/qt6/bin/qmlformat" },
      },
      formatters_by_ft = {
        qml = { "qmlformat" },
      },
    },
  },
}
