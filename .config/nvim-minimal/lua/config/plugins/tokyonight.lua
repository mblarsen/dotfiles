return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    plugins = {
      mini_animate = true,
      mini_clue = true,
      mini_completion = true,
      mini_cursorword = true,
      mini_diff = true,
      mini_files = true,
      mini_hipatterns = true,
      mini_icons = true,
      mini_surround = true,
      snacks = true,
      treesitter = true,
    },
  },
  config = function(_, opts)
    require("tokyonight").setup(opts)
    vim.cmd [[colorscheme tokyonight]]
  end,
}
