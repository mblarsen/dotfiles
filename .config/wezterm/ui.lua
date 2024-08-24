local M = {}

function M.configure(config)
  config.hide_tab_bar_if_only_one_tab = true
  -- config.tab_bar_at_bottom = true
  -- config.window_background_opacity = 0.95
  config.window_decorations = 'NONE | RESIZE | MACOS_FORCE_DISABLE_SHADOW'
end

return M
