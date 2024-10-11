return {
  "folke/noice.nvim",
  dependencies = { "MunifTanjim/nui.nvim" },
  config = function()
    require("noice").setup {
      lsp = {
        -- Override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
        hover = {
          silent = true,
        },
        progress = {
          enabled = true,
        },
      },
      messages = {
        view = "mini",
        view_warn = "mini",
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
        lsp_doc_border = true,
      },
    }
  end,
}
