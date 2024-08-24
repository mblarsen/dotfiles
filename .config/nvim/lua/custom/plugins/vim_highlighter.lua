return {
  "azabiong/vim-highlighter",
  -- cmd = { "Hi", "HiSearch" },
  -- keys = { "f<enter>", "n", "N", mode = { "n" } },
  config = function()
    vim.keymap.set("n", "n", "<Cmd>call HiSearch('n')<CR>", { noremap = true, silent = true })
    vim.keymap.set("n", "N", "<Cmd>call HiSearch('N')<CR>", { noremap = true, silent = true })
  end,
}
