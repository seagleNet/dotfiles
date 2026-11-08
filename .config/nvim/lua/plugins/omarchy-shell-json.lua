-- Format ~/.config/omarchy/shell.json the way Omarchy's CLI writes it
-- (jq -S: keys sorted, 2-space indent), so format-on-save doesn't fight it.
-- Every other JSON file keeps the default formatter.
local omarchy_shell_json = vim.fn.resolve(vim.fn.expand("~/.config/omarchy/shell.json"))

return {
  "stevearc/conform.nvim",
  opts = {
    formatters = {
      jq_sorted = {
        command = "jq",
        args = { "-S", "--indent", "2", "." },
      },
    },
    formatters_by_ft = {
      json = function(bufnr)
        if vim.fn.resolve(vim.api.nvim_buf_get_name(bufnr)) == omarchy_shell_json then
          return { "jq_sorted" }
        end
        return {}
      end,
    },
  },
}
