return {
  "Chaitanyabsprip/fastaction.nvim",
  -- "mblarsen/fastaction.nvim",
  -- dir = "/Users/mbl/dev/mblarsen/fastaction.nvim",
  enabled = true,
  ---@type FastActionConfig
  opts = {
    dismiss_keys = { "<c-c>", "<c-e>", "q" },
    brackets = { "", "" },
    popup = {
      title = false,
      border = "rounded",
      highlight = {
        title = "@keyword",
        key = "@keyword.debug",
        source = "CursorLineSign",
      },
    },
    priority = {
      lua = {
        { key = "d", pattern = "disable diagnostics on this line", order = 1 },
        { key = "i", pattern = "disable diagnostics in this file", order = 2 },
        { key = "s", pattern = "disable diagnostics in the workspace", order = 3 },
      },
    },
  },
  config = function(_, opts)
    require("fastaction").setup(opts)

    vim.keymap.set("n", "ta", function()
      require("fastaction").code_action {
        select_first = true,
        notify = true,
      }
    end, { noremap = true, silent = true, desc = "Apply first code action" })

    vim.keymap.set({ "n", "x" }, "tc", function()
      require("fastaction").code_action()
    end, { noremap = true, silent = true, desc = "Show code actions" })
  end,
}
