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
            checker_args = "-vet -strict-style -vet-tabs -vet-unused-procedures -vet-packages:main -vet-uninitialized -vet-nil-deref -vet-using-param -disallow-do -warnings-as-errors",
            enable_semantic_tokens = true,
          },
        },
      },
    },
  },
}
