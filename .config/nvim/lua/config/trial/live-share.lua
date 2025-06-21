return {
  "azratul/live-share.nvim",
  dependencies = {
    "jbyuki/instant.nvim",
  },

  version = "v1.0.0",
  init = function()
    vim.g.instant_username = "mbl"
  end,
  opts = {},
  config = function()
    require("live-share").setup {}
  end,
}
