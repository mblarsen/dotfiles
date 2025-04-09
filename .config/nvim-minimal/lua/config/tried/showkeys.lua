return {
  "nvchad/showkeys",
  keys = { "gts" },
  cmd = { "ShowkeysToggle" },
  opts = {
    timeout = 2,
    maxkeys = 7,
    showcount = true,
    position = "bottom-center",
    excluded_modes = { "i" },
    -- more opts https://github.com/NvChad/showkeys/blob/main/lua/showkeys/state.lua#L7
  },
  config = function(_, opts)
    require("showkeys").setup(opts)
    vim.keymap.set("n", "gts", "<Cmd>ShowkeysToggle<cr>", { desc = "Toggle Showkeys", silent = true })
    -- vim.cmd [[ShowkeysToggle]]
  end,
}
