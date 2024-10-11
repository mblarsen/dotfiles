return {
  "NStefan002/screenkey.nvim",
  keys = { "gts" },
  cmd = { "Screenkey" },
  opts = {
    clear_after = 3,
    group_mappings = true,
    win_opts = {
      border = "none",
    },
  },
  config = function(_, opts)
    require("screenkey").setup(opts)
    vim.keymap.set("n", "gts", "<Cmd>Screenkey<cr>", { desc = "Toggle Screenkey", silent = true })
  end,
}
