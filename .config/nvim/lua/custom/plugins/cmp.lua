return {
  "hrsh7th/nvim-cmp",
  enabled = true,
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "onsails/lspkind.nvim",
    "petertriho/cmp-git",
    "hrsh7th/cmp-calc",
    "SergioRibera/cmp-dotenv",
  },
  config = function()
    require "custom.completion"
  end,
}
