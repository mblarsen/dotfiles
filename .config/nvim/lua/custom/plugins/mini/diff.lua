require("mini.diff").setup {
  view = {
    style = "sign",
  },
  options = {
    -- algorithm = "patience",
    algorithm = "minimal", -- see :h vim.diff()
  },
}

vim.keymap.set("n", "ghp", require("mini.diff").toggle_overlay)

return {}
