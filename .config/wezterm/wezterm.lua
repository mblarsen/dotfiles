local wezterm = require("wezterm")

local config = wezterm.config_builder()

local font = require("font")
local keys = require("keys")
local nvim = require("nvim")
local theme = require("theme")
local ui = require("ui")

font.configure(config)
keys.configure(config)
nvim.configure(config)
theme.configure(config)
ui.configure(config)

config.scrollback_lines = 10000

return config
