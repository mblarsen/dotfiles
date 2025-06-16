return {
  "SmiteshP/nvim-navic",
  enabled = true,
  dependencies = { "neovim/nvim-lspconfig" },
  opts = {
    lsp = {
      auto_attach = true,
      preference = nil,
    },
  },
  config = function(_, opts)
    require("nvim-navic").setup(opts)
  end,
}
