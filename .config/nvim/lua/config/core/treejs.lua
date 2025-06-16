return {
  "Wansmer/treesj",
  enabled = true,
  keys = { "<space>m" },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  opts = {
    ---@type number If line after join will be longer than max value, node will not be formatted
    max_join_length = 180,
  },
}
