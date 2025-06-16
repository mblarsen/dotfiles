return {
  "saghen/blink.cmp",
  enabled = true,
  event = "VimEnter",
  version = "1.*",
  dependencies = {
    {
      "L3MON4D3/LuaSnip",
      version = "2.*",
      build = (function()
        return "make install_jsregexp"
      end)(),
      opts = {},
    },
    {
      "saghen/blink.compat",
      lazy = true,
      opts = {},
      config = function()
        -- monkey patch cmp.ConfirmBehavior for Avante
        require("cmp").ConfirmBehavior = {
          Insert = "insert",
          Replace = "replace",
        }
      end,
    },
    "folke/lazydev.nvim",
  },
  --- @module 'blink.cmp'
  --- @type blink.cmp.Config
  opts = {
    keymap = {
      preset = "default",
    },

    appearance = {
      nerd_font_variant = "mono",
    },

    completion = {
      accept = {
        auto_brackets = {
          enabled = false,
        },
      },
      keyword = {
        range = "full", -- "prefix"
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 350,
      },
      ghost_text = {
        enabled = true,
      },
      list = {
        selection = {
          preselect = false,
          auto_insert = false,
        },
      },
      menu = {
        draw = {
          treesitter = { "lsp" },
        },
      },
    },

    sources = {
      default = { "lsp", "path", "snippets", "buffer", "copilot" },
      per_filetype = {
        lua = { "lsp", "path", "snippets", "lazydev", "buffer" },
        markdown = { "lsp", "path", "buffer" },
        AvanteInput = {
          "avante_commands",
          "avante_files",
          "avante_mentions",
          "buffer",
          "path",
        },
      },
      providers = {
        lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
        copilot = {
          name = "copilot",
          module = "blink-cmp-copilot",
          score_offset = 100,
          async = true,
        },
        avante_commands = {
          name = "avante_commands",
          module = "blink.compat.source",
          score_offset = 90, -- show at a higher priority than lsp
          opts = {},
        },
        avante_files = {
          name = "avante_commands",
          module = "blink.compat.source",
          score_offset = 100, -- show at a higher priority than lsp
          opts = {},
        },
        avante_mentions = {
          name = "avante_mentions",
          module = "blink.compat.source",
          score_offset = 1000, -- show at a higher priority than lsp
          opts = {},
        },
      },
    },

    snippets = {
      preset = "luasnip",
    },

    fuzzy = {
      implementation = "prefer_rust_with_warning",
    },

    -- Shows a signature help window while you type arguments for a function
    signature = {
      enabled = true,
    },
  },
}
