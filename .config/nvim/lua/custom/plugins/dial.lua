-- Cycle through values
return {
  "monaqa/dial.nvim",
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
    vim.keymap.set("n", "g<CR>", function()
      require("dial.map").manipulate("increment", "normal")
    end, { desc = "Dial cycle symbol" })
    vim.keymap.set("n", "<C-a>", function()
      require("dial.map").manipulate("increment", "normal")
    end, { desc = "Dial smart increment" })
    vim.keymap.set("n", "<C-x>", function()
      require("dial.map").manipulate("decrement", "normal")
    end, { desc = "Dial smart decrement" })
  end,
}
