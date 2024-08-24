return {
  "jakobkhansen/journal.nvim",
  keys = { "<leader>j" },
  config = function()
    require("journal").setup()
    vim.keymap.set("n", "<leader>jj", function()
      require("journal").command "week"
    end, { silent = true })
    vim.keymap.set("n", "<leader>j<", function()
      require("journal").command "week -1"
    end, { silent = true })
    vim.keymap.set("n", "<leader>jd", function()
      require("journal").command "day"
    end, { silent = true })
    vim.keymap.set("n", "<leader>jx", function()
      vim.api.nvim_feedkeys(":Journal", "n", false)
    end, { silent = true })
  end,
}
