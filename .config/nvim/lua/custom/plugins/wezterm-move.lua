local no_remap = { noremap = true }

return {
  "letieu/wezterm-move.nvim",
  config = function()
    vim.keymap.set("n", "gth", function()
      require("wezterm-move").move "h"
    end, no_remap)
    vim.keymap.set("n", "gtj", function()
      require("wezterm-move").move "j"
    end, no_remap)
    vim.keymap.set("n", "gtk", function()
      require("wezterm-move").move "k"
    end, no_remap)
    vim.keymap.set("n", "gtl", function()
      require("wezterm-move").move "l"
    end, no_remap)
  end,
}
