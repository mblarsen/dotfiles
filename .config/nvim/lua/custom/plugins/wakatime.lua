return {
  "wakatime/vim-wakatime",
  lazy = false,
  priority = 999,
  config = function()
    vim.g.wakatime_CLIPath = "/opt/homebrew/bin/wakatime-cli"
  end,
}
