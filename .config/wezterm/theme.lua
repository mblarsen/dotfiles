local wezterm = require("wezterm")

local M = {}

---@diagnostic disable-next-line: unused-function, unused-local
local function rose_pine(config)
  local theme = wezterm.plugin.require("https://github.com/neapsix/wezterm").moon -- main, moon, dawn
  config.colors = theme.colors()
end

---@diagnostic disable-next-line: unused-function, unused-local
local function tokyo_night(config)
  config.color_scheme = "Tokyo Night Storm"
end

local function spaceduck(config)
  config.color_schemes["Spaceduck"] = {
    -- Default colors
    background = "#0f111b",
    foreground = "#ecf0c1",

    -- Normal colors
    black = "#000000",
    red = "#e33400",
    green = "#5ccc96",
    yellow = "#b3a1e6",
    blue = "#00a3cc",
    magenta = "#f2ce00",
    cyan = "#7a5ccc",
    white = "#686f9a",

    -- Bright colors
    brblack = "#686f9a",
    brred = "#e33400",
    brgreen = "#5ccc96",
    bryellow = "#b3a1e6",
    brblue = "#00a3cc",
    brmagenta = "#f2ce00",
    brcyan = "#7a5ccc",
    brwhite = "#f0f1ce",
  }
  config.color_scheme = "Spaceduck"
end

function M.configure(config)
  rose_pine(config)
  spaceduck(config)
  -- tokyo_night(config)
end

return M
