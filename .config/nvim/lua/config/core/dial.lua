-- Cycle through values
return {
  "monaqa/dial.nvim",
  enabled = true,
  keys = { "<c-a>", "<c-x>" },
  config = function()
    local augend = require "dial.augend"
    local create = augend.constant.new

    require("dial.config").augends:register_group {
      default = {
        augend.integer.alias.decimal,
        augend.semver.alias.semver,
        augend.hexcolor.new { case = "prefer_lower" },
        augend.date.alias["%Y/%m/%d"],
        augend.date.alias["%H:%M:%S"],
        augend.date.alias["%H:%M"],

        create { elements = { "legacy", "agentic" } },
        create { elements = { "development", "production" } },
        create { elements = { "Debug", "Info", "Warn", "Warning", "Error", "Fatal" } },
        create { elements = { "DEBUG", "INFO", "WARN", "WARNING", "ERROR" } },
        create { elements = { "let", "const" } },
        create { elements = { "True", "False" } },
        create { elements = { "||", "&&" }, word = false },
        create { elements = { "true", "false" } },
        create { elements = { "and", "or" } },
        create { elements = { "===", "!==" }, word = false },
        create { elements = { "==", "!=" }, word = false },
        create { elements = { "- [ ]", "- [x]" }, word = false },
      },
    }
    vim.keymap.set("n", "<C-a>", function()
      require("dial.map").manipulate("increment", "normal")
    end, { desc = "Dial : Smart increment" })
    vim.keymap.set("n", "<C-x>", function()
      require("dial.map").manipulate("decrement", "normal")
    end, { desc = "Dial : Smart decrement" })
  end,
}
