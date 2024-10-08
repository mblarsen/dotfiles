local wezterm = require 'wezterm'

local M = {}

---@diagnostic disable-next-line: unused-function, unused-local
local function mono_lisa(config)
  config.line_height = 1.2
  config.font_size = 16.0
  config.font = wezterm.font 'MonoLisa MonoLisaCustom'
end

---@diagnostic disable-next-line: unused-function, unused-local
local function monocraft(config)
  config.line_height = 1.4
  config.font_size = 18.0
  config.font = wezterm.font 'Monocraft'
end

---@diagnostic disable-next-line: unused-function, unused-local
local function mira_code(config)
  config.line_height = 1.5
  config.font_size = 16.0
  config.font = wezterm.font 'Miracode'
end

function M.configure(config)
  config.adjust_window_size_when_changing_font_size = false

  mono_lisa(config)
  -- monocraft(config)
  -- mira_code(config)
end

return M
