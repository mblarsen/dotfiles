require("lazy").setup({
  { import = "config/colors" },
  { import = "config/core" },
  { import = "config/optional" },
  { import = "config/trial" },
}, {
  change_detection = {
    notify = false,
  },
  ui = {
    border = "rounded",
    size = {
      width = 0.95,
      height = 0.8,
    },
  },
})
