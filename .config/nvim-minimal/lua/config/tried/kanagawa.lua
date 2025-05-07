return {
  "rebelot/kanagawa.nvim",
  enabled = false,
  lazy = false,
  priority = 1000,
  opts = {
    colors = {
      theme = {
        all = {
          ui = {
            -- Remove the background of LineNr, {Sign,Fold}Column and friends
            bg_gutter = "none",
          },
        },
      },
    },
  },
  config = function(_spec, opts)
    require("kanagawa").setup(opts)
    vim.cmd [[colorscheme kanagawa]]
  end,
}
