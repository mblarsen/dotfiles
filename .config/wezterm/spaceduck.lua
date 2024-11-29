local space_duck = {}

local space_duck_palette = {
  base = "#0f111b",
  overlay = "#26233a", -- You can adjust this if necessary
  muted = "#686f9a",
  text = "#ecf0c1",
  love = "#e33400",
  gold = "#b3a1e6",
  rose = "#f2ce00",
  pine = "#00a3cc",
  foam = "#7a5ccc",
  iris = "#5ccc96",
  highlight_high = "#524f67", -- You can choose a suitable highlight color
}

local space_duck_active_tab = {
  bg_color = space_duck_palette.overlay,
  fg_color = space_duck_palette.text,
}

local space_duck_inactive_tab = {
  bg_color = space_duck_palette.base,
  fg_color = space_duck_palette.muted,
}

function space_duck.colors()
  return {
    foreground = space_duck_palette.text,
    background = space_duck_palette.base,
    cursor_bg = space_duck_palette.highlight_high,
    cursor_border = space_duck_palette.highlight_high,
    cursor_fg = space_duck_palette.text,
    selection_bg = "#2a283e", -- You can adjust this if necessary
    selection_fg = space_duck_palette.text,

    ansi = {
      space_duck_palette.base,
      space_duck_palette.love,
      space_duck_palette.iris,
      space_duck_palette.gold,
      space_duck_palette.foam,
      space_duck_palette.pine,
      space_duck_palette.rose,
      space_duck_palette.text,
    },

    brights = {
      space_duck_palette.muted,
      space_duck_palette.love,
      space_duck_palette.iris,
      space_duck_palette.gold,
      space_duck_palette.foam,
      space_duck_palette.pine,
      space_duck_palette.rose,
      space_duck_palette.text,
    },

    tab_bar = {
      background = space_duck_palette.base,
      active_tab = space_duck_active_tab,
      inactive_tab = space_duck_inactive_tab,
      inactive_tab_hover = space_duck_active_tab,
      new_tab = space_duck_inactive_tab,
      new_tab_hover = space_duck_active_tab,
      inactive_tab_edge = space_duck_palette.muted, -- (Fancy tab bar only)
    },
  }
end

function space_duck.window_frame()
  return {
    active_titlebar_bg = space_duck_palette.base,
    inactive_titlebar_bg = space_duck_palette.base,
  }
end

return {
  space_duck = space_duck,
}
