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
      mappings = {
        source = "<leader>cs",
      },
    }

    -- Apply first
    vim.keymap.set("n", "<leader>ca", function ()
      require("clear-action").code_action({
        first = true,
        filter = filter,
      })
    end, { noremap = true, silent = true })

    -- List code actions
    vim.keymap.set("n", "<leader>cc", function ()
      require("clear-action").code_action({
        filter = filter,
      })
    end, { noremap = true, silent = true })
  end,
}
