return {
  "shellRaining/hlchunk.nvim",
  enabled = true,
  event = { "UIEnter" },
  config = function()
    require("hlchunk").setup {
      blank = {
        enable = false,
      },
      chunk = {
        enable = true,
        chars = {
          horizontal_line = "─",
          vertical_line = "│",
          left_top = "╭",
          left_bottom = "╰",
          right_arrow = ">",
        },
        style = "#FFD700",
      },
      indent = {
        enable = true,
        ahead_lines = 2,
        filter_list = {
          function(v)
            -- Skip first line
            return v.level ~= 1
          end,
        },
        style = {
          "#3f3c52",
          "#57536F",
        },
      },
      line_num = {
        enable = false,
      },
    }
  end,
}
