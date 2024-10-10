require("lazy").setup({
  { import = "custom/colors" },
  { import = "custom/plugins" },
}, {
  change_detection = {
    notify = false,
  },
  install = {
    colorscheme = { "rose-pine" },
  },
  ui = {
    border = "rounded",
    size = {
      width = 0.95,
      height = 0.8,
    },
  },
})
