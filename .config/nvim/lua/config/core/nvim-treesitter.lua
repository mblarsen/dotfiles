local function disable_by_ft(lang, buf)
  local disable_for = {
    "vim", -- the command line edit mode
    "Avante",
    "AvanteInput",
  }
  -- local filetype = vim.api.nvim_buf_get_option(buf, "filetype")
  local filetype = vim.bo.filetype

  for _, ft in ipairs(disable_for) do
    if ft == filetype then
      return true
    end
  end
  return false
end

return {
  "nvim-treesitter/nvim-treesitter",
  enabled = true,
  config = function()
    require("nvim-treesitter.configs").setup {
      auto_install = true,
      sync_install = true,
      modules = {},
      ignore_install = {},
      ensure_installed = {
        "lua",
        "vim",
        "vimdoc",
      },
      highlight = {
        enable = true,
        disable = disable_by_ft,
      },
      indent = {
        enable = true,
        disable = disable_by_ft,
      },
      incremental_selection = {
        enable = true,
        disable = disable_by_ft,
        keymaps = {
          init_selection = "<cr>",
          scope_incremental = nil,
          node_incremental = "<cr>",
          node_decremental = "<bs>",
        },
      },
    }
  end,
}
