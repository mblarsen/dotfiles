return {
  "github/copilot.vim",
  enabled = false,
  config = function()
    vim.keymap.set("i", "<C-;>", 'copilot#Accept("\\<CR>")', {
      expr = true,
      replace_keycodes = false,
    })
    vim.g.copilot_no_tab_map = true
  end,
}
