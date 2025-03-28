return {
  "azabiong/vim-highlighter",
  config = function()
    vim.keymap.set(
      "n",
      "n",
      "<Cmd>call HiSearch('n')<CR>zz",
      { noremap = true, silent = true, desc = "Search highlight forward" }
    )
    vim.keymap.set(
      "n",
      "N",
      "<Cmd>call HiSearch('N')<CR>zz",
      { noremap = true, silent = true, desc = "Search highlight backward" }
    )
  end,
}
