local wezterm = require 'wezterm'
local helpers = require 'helpers'

local M = {}

function M.configure(config)
  config.debug_key_events = true

  config.leader = {
    key = 'b',
    mods = 'CTRL',
    timeout_milliseconds = 1000,
  }

  helpers.merge_keys(config, {
    {
      key = '%',
      mods = 'LEADER',
      action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
      key = '"',
      mods = 'LEADER',
      action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    {
      key = 'z',
      mods = 'LEADER',
      action = wezterm.action.TogglePaneZoomState,
    },
    {
      key = ',',
      mods = 'CMD',
      action = wezterm.action.SpawnCommandInNewWindow {
        cwd = os.getenv 'WEZTERM_CONFIG_DIR',
        args = { os.getenv 'SHELL', '-c', '$EDITOR $WEZTERM_CONFIG_FILE' },
      },
    },
  })
end

return M
