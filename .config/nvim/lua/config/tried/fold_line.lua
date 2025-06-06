-- used in combination with ufo
return {
  "gh-liu/fold_line.nvim",
  enabled = false,
  event = "VeryLazy",
  init = function()
    -- change the char of the line, see the `Appearance` section
    vim.g.fold_line_current_fold_only = true
    vim.g.fold_line_char_open_start = "╭"
    vim.g.fold_line_char_open_end = "╰"
    vim.cmd "highlight link FoldLineCurrent @float"
  end,
}
