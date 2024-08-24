return {
  "tris203/precognition.nvim",
  keys = { "gtp", "gtP" },
  config = function()
    require("precognition").setup {
      startVisible = false,
      showBlankVirtLine = true,
      highlightColor = { link = "@keyword.debug" },
    }
    vim.keymap.set("n", "gtp", require("precognition").peek, { desc = "Show navigation hints until next key" })
    vim.keymap.set("n", "gtP", require("precognition").toggle, { desc = "Toggle navigation hints" })
  end,
}
