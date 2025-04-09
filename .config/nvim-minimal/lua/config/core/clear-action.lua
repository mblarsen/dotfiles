local unwanted_actions = {
  "Move to a new file",
}

-- Filter out unwanted actions
local filter = function(action)
  for _, unwanted in ipairs(unwanted_actions) do
    if vim.startswith(action.title, unwanted) then
      return false
    end
  end
  return true
end

return {
  "luckasRanarison/clear-action.nvim",
  event = { "BufReadPre" },
  config = function()
    require("clear-action").setup {
      signs = {
        enable = false,
        show_count = false,
        show_label = false,
      },
      -- mappings = {
      --   source = "gra",
      -- },
    }

    vim.keymap.set("n", "ta", function()
      require("clear-action").code_action {
        first = true,
        filter = filter,
      }
    end, { noremap = true, silent = true, desc = "Apply first code action" })

    vim.keymap.set("n", "tc", function()
      require("clear-action").code_action {
        filter = filter,
      }
    end, { noremap = true, silent = true, desc = "Show code actions" })
  end,
}
