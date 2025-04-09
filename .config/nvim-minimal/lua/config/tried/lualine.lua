local lualine_c = {
  {
    "pretty_path",
    highlights = {
      modified = { fg = "#e26d5c", bold = true, italic = false },
      directory = "Operator",
      path_sep = "Operator",
    },
  },
}

return {
  "nvim-lualine/lualine.nvim",
  enabled = false,
  dependencies = {
    "bwpge/lualine-pretty-path",
  },
  config = function()
    require("lualine").setup {
      options = {
        icons_enabled = true,
        theme = "auto",
        section_separators = "",
        component_separators = "",
      },
      sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = lualine_c,
        lualine_x = { "diagnostics" },
        lualine_y = {},
        lualine_z = {},
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = lualine_c,
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = { "branch" },
        lualine_y = {},
        lualine_z = {},
      },
      inactive_winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "branch" },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
    }
  end,
}
