return {
  'shellRaining/hlchunk.nvim',
  event = { 'UIEnter' },
  config = function()
    require('hlchunk').setup {
      blank = {
        enable = false,
      },
      indent = {
        enable = false,
      },
      line_num = {
        enable = false,
        style = '#F8F8FF',
      },
      chunk = {
        chars = {
          horizontal_line = '─',
          vertical_line = '│',
          left_top = '╭',
          left_bottom = '╰',
          right_arrow = '>',
        },
        style = '#FFD700',
      },
    }
  end,
}
