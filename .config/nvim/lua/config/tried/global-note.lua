return {
  "backdround/global-note.nvim",
  enabled = false,
  keys = {
    "<leader>n",
  },
  config = function()
    local global_note = require "global-note"
    global_note.setup {
      title = "Notes",
    }

    vim.keymap.set("n", "<leader>n", global_note.toggle_note, {
      desc = "Toggle global note",
    })
  end,
}
