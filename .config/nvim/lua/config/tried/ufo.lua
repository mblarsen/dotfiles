-- used in combination with fold_line
return {
  "kevinhwang91/nvim-ufo",
  dependencies = {
    "kevinhwang91/promise-async",
  },
  config = function()
    require("ufo").setup {
      provider_selector = function()
        return { "treesitter", "indent" }
      end,
    }
    vim.o.foldcolumn = "0" -- '0' is not bad
    vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
    vim.cmd "highlight link UfoFoldedEllipsis @float"
  end,
}
