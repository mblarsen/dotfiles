return {
  "rlane/pounce.nvim",
  keys = { "f/" },
  config = function()
    require "pounce"
    local map = vim.keymap.set
    map("n", "f/", function()
      require("pounce").pounce {}
    end)
  end,
}
