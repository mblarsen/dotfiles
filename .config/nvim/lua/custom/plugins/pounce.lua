return {
  "rlane/pounce.nvim",
  keys = { "f/" },
  config = function()
    require "pounce"
    local map = vim.keymap.set
    map("n", "f/", function()
      require("pounce").pounce {}
    end)
    map("n", "f?", function()
      require("pounce").pounce { do_repeat = true }
    end)
    -- map("n", "S", function()
    --   require("pounce").pounce { do_repeat = true }
    -- end)
    -- map("x", "s", function()
    --   require("pounce").pounce {}
    -- end)
    -- map("o", "gs", function()
    --   require("pounce").pounce {}
    -- end)
    -- map("n", "S", function()
    --   require("pounce").pounce { input = { reg = "/" } }
    -- end)
    -- ?
  end,
}
