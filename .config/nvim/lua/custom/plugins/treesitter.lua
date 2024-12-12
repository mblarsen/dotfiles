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
        enable = false,
      },
      indent = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
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
