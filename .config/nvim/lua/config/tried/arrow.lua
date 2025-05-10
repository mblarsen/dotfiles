return {
  "otavioschwanck/arrow.nvim",
  enabled = false,
  keys = { ";" },
  opts = {
    show_icons = true,
    leader_key = ";",
    -- buffer_leader_key = 'm',
    per_buffer_config = {
      satellite = {
        lines = 5,
        enable = true,
      },
    },
  },
}
