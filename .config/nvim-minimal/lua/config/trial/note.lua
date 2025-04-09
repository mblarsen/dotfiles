return {
  "gsuuon/note.nvim",
  opts = {},
  cmd = "Note",
  ft = "note",
  keys = {
    {
      "<leader>rn", -- [r]ead [n]otes
      function()
        Snacks.picker.grep {
          dirs = { require("note.api").current_note_root() },
        }
      end,
      mode = "n",
    },
  },
}
