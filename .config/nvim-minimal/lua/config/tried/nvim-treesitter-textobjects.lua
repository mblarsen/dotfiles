-- NOTE: Not using anymore since mini.ai replaces most of what I use from here

return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  enabled = false,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        include_surrounding_whitespace = true,
        keymaps = {
          ["ap"] = "@parameter.outer",
          ["ip"] = "@parameter.inner",
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ai"] = "@conditional.outer",
          ["ii"] = "@conditional.inner",
          ["at"] = "@comment.outer",
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ["]p"] = "@parameter.inner",
        },
        swap_previous = {
          ["[p"] = "@parameter.inner",
        },
      },
      lsp_interop = {
        enable = true,
        border = "none",
        floating_preview_opts = {
          border = "rounded",
        },
        peek_definition_code = {
          ["<leader>df"] = "@function.outer",
          ["<leader>dF"] = "@class.outer",
        },
      },
    },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}
