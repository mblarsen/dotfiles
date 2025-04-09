return {
  "nvim-telescope/telescope.nvim",
  enabled = false,
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    -- Setup up picker keymaps
    require("config.picker_telescope").setup {
      -- Telescope doesn't have a file explorer so using the one from Snacks
      explorer = require("snacks").picker.explorer,
    }
  end,
}
