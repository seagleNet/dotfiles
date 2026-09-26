return {
  "https://gitlab.com/gitlab-org/editor-extensions/gitlab.vim.git",
  event = { "BufReadPre", "BufNewFile" },
  ft = { "go", "javascript", "python", "ruby" },
  opts = {
    statusline = {
      enabled = true,
    },
    code_suggestions = {
      enabled = false,
    },
  },
}
