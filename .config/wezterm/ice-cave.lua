local M = {}

local hl = {}
local gray0 = "#1e2124"
local gray1 = "#212429"
local gray2 = "#24282d"
local gray3 = "#262D31"
local gray4 = "#36393e"
local gray5 = "#545565"
local gray6 = "#5D5F71"
local gray8 = "#CCD5E5"
local gray9 = "#D3D9E4"
local red1 = "#c3a4b3"
local red2 = "#e26d5c"
local red3 = "#ed333b"
local yellow1 = "#e8a63b"
local yellow2 = "#e2b05c"
local blue = "#4b8b51"
local green2 = "#b3c3a4"
local blue1 = "#566ab1"
local blue2 = "#99ABCB"
local blue3 = "#98B4FE"

function M.colors()
  local theme = {
    foreground = gray8,
    background = gray1,
    cursor_bg = red3,
    cursor_fg = grey9,
  }

  ansi = {
    red1,
    red2,
    red3,
    yellow1,
    yellow2,
    green1,
    green2,
    blue1,
    blue2,
    blue3,
  }

  return theme
end

return M
