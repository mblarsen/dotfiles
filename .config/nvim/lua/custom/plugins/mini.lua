return {
  {
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

      require("mini.ai").setup()

      require("mini.diff").setup {
        view = {
          style = "sign",
        },
        options = {
          -- algorithm = "patience",
          algorithm = "minimal", -- see :h vim.diff()
        },
      }
      vim.keymap.set("n", "ghp", require("mini.diff").toggle_overlay)

      require("mini.files").setup {
        mappings = {
          go_in_plus = "<cr>",
          go_out_plus = "-",
        },
      }
      vim.keymap.set("n", "-", function()
        require("mini.files").open(vim.api.nvim_buf_get_name(0))
      end, { desc = "Open parent directory" })

      require("mini.git").setup()
      require("mini.surround").setup()
      require("mini.operators").setup()
    end,
  },
  -- require("mini.indentscope").setup {
  --   draw = {
  --     animation = function(s, n)
  --       return s / n * 20
  --     end,
  --     -- animation = require("mini.indentscope").gen_animation.cubic(),
  --   },
  --   symbol = "│",
  -- }
  -- {
  --   "echasnovski/mini.basics",
  --   version = false,
  --   opts = {
  --     options = {
  --       basic = true,
  --       extra_ui = true,
  --       win_borders = "single",
  --     },
  --     silent = true,
  --   },
  -- },
  -- {
  --   "echasnovski/mini.ai",
  --   version = false,
  --   event = "BufRead",
  --   opts = {},
  -- },
  -- {
  --   "echasnovski/mini.surround",
  --   version = false,
  --   event = "BufRead",
  --   opts = {},
  -- },
  -- {
  --   "echasnovski/mini.operators",
  --   keys = { "gx", "g=", "gm", "gr", "gs" },
  --   opts = {},
  -- },
  -- {
  --   "echasnovski/mini.comment",
  --   version = false,
  --   keys = {
  --     "gcc",
  --     { "gc", mode = { "v", "x" } },
  --   },
  --   opts = {},
  -- },
}
