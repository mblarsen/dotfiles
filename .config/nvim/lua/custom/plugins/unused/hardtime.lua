return {
  "m4xshen/hardtime.nvim",
  enabled = false, -- doesn't work with mini.files
  dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  opts = {
    disabled_filetypes = { "qf", "lazy", "mason", "oil", "minifiles" },
    restriction_mode = "hint",
  },
}
