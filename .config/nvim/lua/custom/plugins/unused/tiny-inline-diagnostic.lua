return {
  "rachartier/tiny-inline-diagnostic.nvim",
  enabled = false,
  config = function()
    vim.opt.updatetime = 100
    require("tiny-inline-diagnostic").setup {
      signs = {
        arrow = "",
      },
    }
  end,
}
