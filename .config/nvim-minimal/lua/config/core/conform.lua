return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("conform").setup {
      formatters = {
        eslint_d = {
          env = {
            ESLINT_USE_FLAT_CONFIG = "true",
          },
        },
      },
      formatters_by_ft = {
        ["*"] = { "trim_newlines" },
        gleam = { "trim_whitespace", "gleam" },
        graphql = { "prettierd", "prettier", stop_after_first = true },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
        css = { "prettierd", "prettier", stop_after_first = true },
        html = { "prettierd", "prettier", stop_after_first = true },
        hbs = { "prettierd", "prettier", stop_after_first = true },
        json = { "trim_whitespace", "jq" },
        lua = { "trim_whitespace", "stylua" },
        markdown = { "prettierd", "prettier", stop_after_first = true },
        python = { "ruff_organize_imports", "ruff_format" },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        yaml = { "prettierd", "prettier", stop_after_first = true },
        go = { "goimports", "gofmt" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },
    }
  end,
}
