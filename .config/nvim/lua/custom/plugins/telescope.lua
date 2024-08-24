return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- "nvim-telescope/telescope-github.nvim",
    -- "ANGkeith/telescope-terraform-doc.nvim",
  },
  config = function()
    require "custom.telescope"
  end,
}
