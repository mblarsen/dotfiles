local files, error = pcall(require, "mini.files")

if error ~= nil then
  vim.notify("Error loading mini.files", vim.log.levels.ERROR)

  vim.keymap.set("n", "-", function()
    vim.cmd [[Explore]]
  end, { desc = "Open parent directory" })

  return {}
end

files.setup {
  mappings = {
    go_in_plus = "<cr>",
  },
}

vim.keymap.set("n", "-", function()
  require("mini.files").open(vim.api.nvim_buf_get_name(0))
end, { desc = "Open parent directory" })

return {}
