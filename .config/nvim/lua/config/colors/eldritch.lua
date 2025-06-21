return {
  "eldritch-theme/eldritch.nvim",
  cond = false,
  lazy = false,
  priority = 1000,
  opts = {},
  config = function(_, opts)
    require("eldritch").setup(opts)
    vim.cmd [[colorscheme eldritch]]
  end,
}
