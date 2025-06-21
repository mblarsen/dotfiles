return {
  "MeanderingProgrammer/render-markdown.nvim",
  enabled = true,
  optional = true,
  ft = { "markdown", "Avante" },
  dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  ---@type render.md.UserConfig
  opts = {
    file_types = {
      "markdown",
      "Avante",
    },
    sign = {
      enabled = false,
    },
    heading = {
      width = "block",
      position = "inline",
      min_width = 70,
    },
    code = {
      style = "full", -- "none", "normal", "language", "full"
      border = "thick",
      width = "block", -- "block", "full",
      language_pad = 0,
      left_pad = 2,
      right_pad = 4,
    },
    dash = {
      width = 70,
    },
    indent = {
      enabled = false,
    },
  },
}
