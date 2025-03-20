vim.api.nvim_create_user_command("Format", function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, end_line:len() },
    }
  end
  require("conform").format { async = true, lsp_format = "fallback", range = range }
end, { range = true })

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
    graphql = { "prettier" },
    javascript = { "trim_whitespace", "prettier" },
    javascriptreact = { "trim_whitespace", "prettier" },
    css = { "prettier" },
    html = { "prettier" },
    json = { "trim_whitespace", "jq" },
    lua = { "trim_whitespace", "stylua" },
    markdown = { "prettier" },
    python = { "ruff_organize_imports", "ruff_format" },
    typescript = { "trim_whitespace", "prettier" },
    typescriptreact = { "trim_whitespace", "prettier" },
    yaml = { "trim_whitespace", "prettier" },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}
