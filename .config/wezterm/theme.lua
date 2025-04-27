local wezterm = require("wezterm")

local M = {}

---@diagnostic disable-next-line: unused-function, unused-local
local function rose_pine(config)
  local theme = wezterm.plugin.require("https://github.com/neapsix/wezterm").moon -- main, moon, dawn
  config.colors = theme.colors()
end

---@diagnostic disable-next-line: unused-function, unused-local
local function tokyo_night(config)
  config.color_scheme = "Tokyo Night Moon"
end

---@diagnostic disable-next-line: unused-function, unused-local
local function ice_cave(config)
  local theme = require("ice-cave")
  config.colors = theme.colors()
end

function M.configure(config)
  -- rose_pine(config)
  -- ice_cave(config)
  -- spaceduck(config)
  tokyo_night(config)
end

return M
