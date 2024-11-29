return {
  "rose-pine/neovim",
  enabled = false,
  name = "rose-pine",
  priority = 1000,
  opts = {
    variant = "moon", -- auto, main, moon, or dawn
    dark_variant = "moon", -- main, moon, or dawn
    styles = {
      bold = true,
      italic = true,
      transparency = false,
    },
  },
  config = function(_, opts)
    require("rose-pine").setup(opts)
    vim.cmd "colorscheme rose-pine"
  end,
}
