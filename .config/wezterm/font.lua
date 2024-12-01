local wezterm = require("wezterm")

local M = {}

---@diagnostic disable-next-line: unused-function, unused-local
local function mono_lisa(config)
  config.line_height = 1.1
  config.font_size = 15.0
  config.font = wezterm.font("MonoLisa MonoLisaCustom")
end

---@diagnostic disable-next-line: unused-function, unused-local
local function monocraft(config)
  config.line_height = 1.4
  config.font_size = 18.0
  config.font = wezterm.font("Monocraft")
end

---@diagnostic disable-next-line: unused-function, unused-local
local function mira_code(config)
  config.line_height = 1.5
  config.font_size = 16.0
  config.font = wezterm.font("Miracode")
end

---@diagnostic disable-next-line: unused-function, unused-local
local function gohu(config)
  config.font = wezterm.font("GohuFont 11 Nerd Font Mono")
  -- config.font = wezterm.font("GohuFont 14 Nerd Font Mono")
  config.line_height = 1.125
  config.font_size = 18.0
end
---
---@diagnostic disable-next-line: unused-function, unused-local
local function commit(config)
  config.font = wezterm.font("CommitMono")
  config.line_height = 1.25
  config.font_size = 18.0
end

function M.configure(config)
  config.adjust_window_size_when_changing_font_size = false

  commit(config)
  -- gohu(config)
  -- mira_code(config)
  -- mono_lisa(config)
  -- monocraft(config)
end

return M
