return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "odin" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ols = {
          init_options = {
            checker_args = "-vet -strict-style -vet-cast -vet-tabs",
            enable_semantic_tokens = true,
          },
        },
      },
    },
  },
}
