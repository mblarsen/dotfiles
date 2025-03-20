require("mini.diff").setup {
  view = {
    style = "sign",
  },
  options = {
    algorithm = "minimal", -- see :h vim.diff()
  },
  config = function (_, opts)
    require("mini.diff").setup(opts)

    vim.keymap.set("n", "ghp", require("mini.diff").toggle_overlay)
  end
}
