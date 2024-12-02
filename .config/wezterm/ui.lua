local M = {}

function M.configure(config)
  config.window_padding = {
    left = 5,
    right = 0,
    top = 5,
    bottom = 0,
  }
  config.command_palette_font_size = 20.0
  config.default_cursor_style = "BlinkingBlock"
  config.hide_tab_bar_if_only_one_tab = true
  -- config.tab_bar_at_bottom = true
  -- config.window_background_opacity = 0.9
  config.window_decorations = "NONE | RESIZE | MACOS_FORCE_DISABLE_SHADOW"
end

return M
