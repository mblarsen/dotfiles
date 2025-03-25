return {
  "bassamsdata/namu.nvim",
  enabled = false,
  config = function()
    require("namu").setup({
      namu_symbols = {
        enable = true,
        options = {
          AllowKinds = {
            python = {
              "Function",
              "Method",
              "Class",
              -- "Module",
              -- "Property",
              -- "Variable",
              -- "Constant",
              -- "Enum",
              -- -- "Interface",
              -- "Field",
              -- -- "Struct",
            },
          }
        }
      },
    })
    local namu = require("namu.namu_symbols")
    vim.keymap.set("n", "<leader>fs", namu.show, {
      desc = "Jump to LSP symbol",
      silent = true,
    })
  end,
}
