return {
  "echasnovski/mini.nvim",
  config = function()
    require("mini.basics").setup {
      options = {
        basic = true,
        extra_ui = true,
        win_borders = "single",
      },
      silent = true,
    }
    require("mini.clue").setup {
      triggers = {
        -- Leader triggers
        { mode = 'n', keys = '<Leader>' },
        { mode = 'x', keys = '<Leader>' },

        -- Built-in completion
        { mode = 'i', keys = '<C-x>' },

        -- `g` key
        { mode = 'n', keys = 'g' },
        { mode = 'x', keys = 'g' },

        -- Marks
        { mode = 'n', keys = "'" },
        { mode = 'n', keys = '`' },
        { mode = 'x', keys = "'" },
        { mode = 'x', keys = '`' },

        -- Registers
        { mode = 'n', keys = '"' },
        { mode = 'x', keys = '"' },
        { mode = 'i', keys = '<C-r>' },
        { mode = 'c', keys = '<C-r>' },

        -- Window commands
        { mode = 'n', keys = '<C-w>' },

        -- `z` key
        { mode = 'n', keys = 'z' },
        { mode = 'x', keys = 'z' },
      },
      clues = {
        require("mini.clue").gen_clues.builtin_completion(),
        require("mini.clue").gen_clues.g(),
        require("mini.clue").gen_clues.marks(),
        require("mini.clue").gen_clues.registers(),
        require("mini.clue").gen_clues.windows(),
        require("mini.clue").gen_clues.z(),
      }
    }
    require("mini.files").setup {
      mappings = {
        go_in_plus = "<cr>",
      },
    }
    require("mini.git").setup()
    require("mini.surround").setup {}

    vim.keymap.set("n", "-", function(...)
      if not MiniFiles.close() then MiniFiles.open(...) end
    end, { desc = "Mini.files : Toggle" })
  end,
}

