local prettier = { "prettierd", "prettier" }
local js_langs = { "eslint_d", "eslint", "prettierd", "prettier" }

require("conform").setup {
  formatters = {
    eslint_d = {
      env = {
        ESLINT_USE_FLAT_CONFIG = "true",
      },
    },
  },
  formatters_by_ft = {
    ["*"] = { "trim_newlines", "typos" },
    gleam = { "trim_whitespace", "gleam" },
    graphql = { { "prettierd", "prettier" } },
    javascript = { "trim_whitespace", js_langs },
    javascriptreact = { "trim_whitespace", js_langs },
    json = { "trim_whitespace", "jq" },
    lua = { "trim_whitespace", "stylua" },
    markdown = { prettier },
    python = { "ruff_format" },
    -- python = { "trim_whitespace", "isort", "black" },
    typescript = { "trim_whitespace", js_langs },
    typescriptreact = { "trim_whitespace", js_langs },
    yaml = { "trim_whitespace", { "taplo", "prettierd", "prettier" } },
  },
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}
