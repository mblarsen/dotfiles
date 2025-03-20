return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    require("mason").setup {
      ensure_installed = {
        "eslint_d",
        "ruff",
        "ruff-lsp",
        "typos-lsp",
        "prettier",
        "pylint",
        "type",
        "stylelua",
      },
      ui = {
        width = 0.95,
        height = 0.8,
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "󰁔",
          package_uninstalled = "✗",
        },
      },
    }
  end,
}
