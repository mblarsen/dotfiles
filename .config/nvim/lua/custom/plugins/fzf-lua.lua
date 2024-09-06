--- https://github.com/ibhagwan/fzf-lua?tab=readme-ov-file#commands
--- :FzfLua builtins
return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("fzf-lua").setup {
      "borderless",
    }
  end,
}
