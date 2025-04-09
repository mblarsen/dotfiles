return {
  "nvim-telescope/telescope.nvim",
  enabled = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  config = function()
    require("telescope").setup {
      pickers = {
        buffers = {
          theme = "ivy",
        },
        find_files = {
          theme = "ivy",
        },
        oldfiles = {
          theme = "ivy",
          cwd_only = true,
        },
        lsp_document_symbols = {
          theme = "ivy",
        },
        lsp_workspace_symbols = {
          theme = "ivy",
        },
      },
      extensions = { fzf = {} },
    }
    require("telescope").load_extension "fzf"

    -- Setup up picker keymaps
    require("config.picker_telescope").setup {
      -- Telescope doesn't have a file explorer so using the one from Snacks
      explorer = require("snacks").picker.explorer,
    }
  end,
}
