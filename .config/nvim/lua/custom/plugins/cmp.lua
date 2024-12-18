return {
  "hrsh7th/nvim-cmp",
  enabled = true,
  -- "iguanacucumber/magazine.nvim",
  -- { "yioneko/nvim-cmp", branch = "perf" },
  -- name = "nvim-cmp", -- Otherwise highlighting gets messed up
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "onsails/lspkind.nvim",
    "petertriho/cmp-git",
  },
  config = function()
    require "custom.completion"
  end,
}
