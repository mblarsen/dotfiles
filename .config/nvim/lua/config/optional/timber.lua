return {
  "Goose97/timber.nvim",
  enabled = true,
  keys = { "gla", "glb", "glj", "glo", "glO" },
  config = function()
    require("timber").setup {
      -- glo insert plain log below
      -- glO insert plain log above
      -- gla (repaet) -> glb add to log buffer then insert log statement
    }
  end,
}
