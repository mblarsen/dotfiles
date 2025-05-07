local function disable_by_ft(lang, buf)
  local disable_for = { "Avante", "AvanteInput" }
  local filetype = vim.api.nvim_buf_get_option(buf, "filetype")

  -- filetype is in disable_for table disable module
  for _, ft in ipairs(disable_for) do
    if ft == filetype then
      return true
    end
  end
  return false
end

return {
  "nvim-treesitter/nvim-treesitter",
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
      },
      incremental_selection = {
        enable = true,
        disable = disable_by_ft,
        keymaps = {
          init_selection = "<TAB>",
          node_incremental = "<TAB>",
          scope_incremental = "<S-TAB>",
          node_decremental = "<BS>",
        },
      },
    }
  end,
}
