return {
  "stevearc/conform.nvim",
  opts = {
    formatters = {
      yamlfmt_ansible = {
        command = "yamlfmt",
        args = { "-conf", os.getenv("HOME") .. "/.config/yamlfmt/yamlfmt-ansible.yaml", "-" },
      },
    },
    formatters_by_ft = {
      yaml = { "yamlfmt" },
      ansible = { "yamlfmt_ansible" },
      python = {
        "ruff_format",
        "ruff_organize_imports",
      },
    },
  },
}
