return {
  "nvim-treesitter/nvim-treesitter",
  -- event = "BufRead",
  config = function()
    require("nvim-treesitter.configs").setup {
      auto_install = true,
      sync_install = true,
      modules = {},
      ignore_install = {},
      ensure_installed = {
        "bash",
        "css",
        "git_config",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "go",
        "html",
        "ini",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "regex",
        "rust",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      },
      highlight = {
        enable = true,
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
