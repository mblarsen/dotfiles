return {
  "rlane/pounce.nvim",
  keys = { "f/", "f?" },
  config = function()
    require "pounce"
    local map = vim.keymap.set
    map("n", "f/", function()
      require("pounce").pounce {}
    end)
    map("n", "f?", function()
      require("pounce").pounce { do_repeat = true }
    end)
  end,
}
