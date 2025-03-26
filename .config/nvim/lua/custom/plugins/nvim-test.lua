return {
  "klen/nvim-test",
  config = function()
    require("nvim-test").setup {}
    vim.keymap.set("n", "<leader>tn", function()
      require("nvim-test").run "nearest"
    end, { desc = "Run nearest test" })
    vim.keymap.set("n", "<leader>tt", function()
      require("nvim-test").run "file"
    end, { desc = "Run file tests" })
    vim.keymap.set("n", "<leader>tl", function()
      require("nvim-test").run_last()
    end, { desc = "Run last test" })
  end,
}
