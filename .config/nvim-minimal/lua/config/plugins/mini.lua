return {
  "echasnovski/mini.nvim",
  config = function()
    ---
    --- mini.ai
    ---
    require("mini.ai").setup { }

    ---
    --- mini.basics
    ---
    require("mini.basics").setup {
      options = {
        basic = true,
        extra_ui = true,
        win_borders = "single",
      },
      silent = true,
    }

    ---
    --- mini.clue
    ---
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

    ---
    --- mini.completion
    --- 
    require("mini.completion").setup {}
    require("mini.snippets").setup {}
    require("mini.icons").setup {}
    MiniIcons.tweak_lsp_kind()
    local group = vim.api.nvim_create_augroup("MyMiniCompletion", {})
    local cmd = function(event, pattern, callback, desc)
      vim.api.nvim_create_autocmd(event, {
        group = group,
        pattern = pattern,
        callback = callback,
        desc = desc,
      })
    end
    cmd("FileType", "snacks_picker_input", function()
      vim.b.minicompletion_disable = true
    end, "Disable locally")

    ---
    --- mini.files
    --- 
    require("mini.files").setup {
      mappings = {
        go_in_plus = "<cr>",
      },
    }
    vim.keymap.set("n", "-", function(...)
      if not MiniFiles.close() then
        require("mini.files").open(vim.api.nvim_buf_get_name(0))
      end
    end, { desc = "Mini.files : Toggle" })

    ---
    --- mini.git
    --- 
    require("mini.git").setup()

    ---
    --- mini.surround
    --- 
    require("mini.surround").setup {}
  end,
}

