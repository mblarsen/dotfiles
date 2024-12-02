return {
  "Dan7h3x/signup.nvim",
  enabled = false,
  branch = "main",
  opts = {
    -- Your configuration options here
  },
  config = function(_, opts)
    require("signup").setup(opts)
  end,
}
