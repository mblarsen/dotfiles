local wezterm = require 'wezterm'

local M = {}

---@diagnostic disable-next-line: unused-function, unused-local
local function rose_pine(config)
  local theme = wezterm.plugin.require('https://github.com/neapsix/wezterm').moon -- main, moon, dawn
  config.colors = theme.colors()
end

---@diagnostic disable-next-line: unused-function, unused-local
local function tokyo_night(config)
  config.color_scheme = 'Tokyo Night Storm'
end

function M.configure(config)
  rose_pine(config)
  -- tokyo_night(config)
end

return M
