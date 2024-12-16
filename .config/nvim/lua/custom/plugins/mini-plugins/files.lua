local files = require "mini.files"
--
files.setup {
  mappings = {
    go_in_plus = "<cr>",
  },
}

vim.keymap.set("n", "-", function()
  files.open(vim.api.nvim_buf_get_name(0))
end, { desc = "Open parent directory" })
