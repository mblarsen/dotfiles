require("lazy").setup({
  { import = "custom/colors" },
  { import = "custom/plugins" },
}, {
  change_detection = {
    notify = false,
  },
  ui = {
    border = "rounded",
    size = {
      width = 0.95,
      height = 0.8,
    },
  },
})

-- set colorscheme
-- vim.cmd [[colorscheme tokyonight]]
-- make the background transparent
-- vim.api.nvim_set_hl(0, "Normal", { bg = "None" })
