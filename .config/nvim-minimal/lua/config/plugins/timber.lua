return {
  "Goose97/timber.nvim",
  version = "*", -- Use for stability; omit to use `main` branch for the latest features
  event = "VeryLazy",
  config = function()
    require("timber").setup {
      -- glo insert plain log below
      -- glO insert plain log above
      -- gla (repaet) -> glb add to log buffer then insert log statement
    }
  end,
}
