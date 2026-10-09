-- taplo reports "this document has been excluded" when it starts without a
-- workspace root, which happens for TOML files outside a git repo (most of
-- ~/.config). Fall back to the file's own directory as the root.
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        taplo = {
          root_dir = function(bufnr, on_dir)
            local fname = vim.api.nvim_buf_get_name(bufnr)
            on_dir(vim.fs.root(fname, { ".taplo.toml", "taplo.toml", ".git" }) or vim.fs.dirname(fname))
          end,
        },
      },
    },
  },
}
