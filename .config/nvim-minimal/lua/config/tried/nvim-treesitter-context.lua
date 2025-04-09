-- https://github.com/nvim-treesitter/nvim-treesitter-context
return {
  "nvim-treesitter/nvim-treesitter-context",
  event = "VeryLazy",
  enabled = true,
  opts = {
    enable = true,
    max_lines = 3,
    -- trim_scope = "inner",
    -- line_numbers = true,
    -- separator = " ",
  },
  config = function(_, opts)
    require("treesitter-context").setup(opts)
    vim.keymap.set("n", "<leader>gc", function()
      require("treesitter-context").go_to_context(vim.v.count1)
    end, { silent = true })
  end,
}
