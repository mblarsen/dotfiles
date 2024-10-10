return {
  "luckasRanarison/clear-action.nvim",
  config = function()
    require("clear-action").setup {
      signs = {
        enable = true,
        show_count = false,
        -- show first action for current line
        show_label = true,
        -- icons = {
        --   quickfix = " ",
        --   refactor = " ",
        --   source = " ",
        --   combined = " ", -- used when combine is set to true or as a fallback when there is no action kind
        -- },
      },
      mappings = {
        code_action = "<leader>cc",
        apply_first = "<leader>ca",
        -- refactor = '<leader>cr',
        source = "<leader>cs",
        quickfix = "<leader>cq",
      },
    }
  end,
}
