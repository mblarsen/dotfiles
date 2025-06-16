local style = "compact"

return {
  "folke/snacks.nvim",
  enabled = true,
  priority = 1000,
  ---@type snacks.Config
  opts = {
    explorer = { enabled = true },
    image = { enabled = true },
    indent = {
      enabled = true,
      only_scope = true, -- only show indent guides of the scope
      only_current = true, -- only show indent guides in the current window
      scope = {
        enabled = false,
      },
      chunk = {
        enabled = true,
        char = { corner_top = "╭", corner_bottom = "╰", horizontal = "─", vertical = "│", arrow = ">" },
      },
    },
    input = { enabled = true },
    notifier = { enabled = true, style = style },
    rename = { enabled = true },
    statuscolumn = {
      enabled = true,
      folds = {
        -- show open folds
        open = true,
      },
    },
    --
    git = { enabled = false },
    words = { enabled = false },
    bigfile = { enabled = false },
    quickfile = { enabled = false },
    scroll = { enabled = false },
    zen = { enabled = false },
  },
  config = function(_, opts)
    require("snacks").setup(opts)

    -- for Eldritch theme
    vim.api.nvim_set_hl(0, "SnacksIndent", { fg = "#414868" })

    -- Extend Mini.basics 'yo' with an indent toggle
    vim.keymap.set("n", "yoi", function()
      if Snacks.indent.enabled then
        Snacks.indent.disable()
      else
        Snacks.indent.enable()
      end
    end, { desc = "Toggle indent lines" })

    -- -- Zoom current window. Not so useful if you use other window manager like tmux or terminal-native
    -- vim.keymap.set("n", "<leader>zz", Snacks.zen.zoom, { desc = "Zen maximize window" })

    -- Setup up picker keymaps
    require("config.picker_snacks").setup()

    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesActionRename",
      callback = function(event)
        Snacks.rename.on_rename_file(event.data.from, event.data.to)
      end,
    })
  end,
}
