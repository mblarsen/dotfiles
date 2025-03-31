require("lazy").setup({
  -- { import = "custom/colors" },
  { import = "config/plugins" },
}, {
  change_detection = {
    notify = false,
  },
  install = {
    colorscheme = { "tokyonight" },
  },
  ui = {
    border = "rounded",
    size = {
      width = 0.95,
      height = 0.8,
    },
  },
})
