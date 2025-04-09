-- Hides config values, useful when sharing screen
return {
  "laytan/cloak.nvim",
  event = { "BufRead" },
  config = function()
    local cloak = require "cloak"
    cloak.setup {
      patterns = {
        {
          file_pattern = { ".env*" },
          cloak_pattern = "=.+",
        },
        {
          file_pattern = { "vault.yml", "vault.yaml" },
          cloak_pattern = { ":.+", "-.+" },
        },
      },
    }
    vim.keymap.set("n", "gtc", cloak.toggle, { noremap = true, silent = true })
  end,
}
