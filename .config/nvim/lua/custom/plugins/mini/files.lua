require("mini.files").setup {
  mappings = {
    go_in_plus = "<cr>",
  },
}
vim.keymap.set("n", "-", function()
  require("mini.files").open(vim.api.nvim_buf_get_name(0))
end, { desc = "Open parent directory" })

return {}
