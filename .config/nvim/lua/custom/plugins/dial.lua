-- Cycle through values
return {
  "monaqa/dial.nvim",
  keys = { "g<cr>" },
  config = function()
    local create = require("dial.augend").constant.new
    require("dial.config").augends:register_group {
      default = {
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
    vim.keymap.set("n", "g<cr>", function()
      require("dial.map").manipulate("increment", "normal")
    end, { desc = "Cycle symbol" })
  end,
}