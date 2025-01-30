return {
  "nvim-telescope/telescope.nvim",
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
    local builtin = require "telescope.builtin"
    vim.keymap.set("n", "<leader>ft", "<cmd>Telescope<CR>", { desc = "Telescope open pickers" })
    -- vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "Telescope buffers" })
    -- vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
    -- vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
    -- vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
    -- vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "Telescope find old files" })
    -- vim.keymap.set("n", "<leader>fO", function()
    --   builtin.oldfiles { cwd_only = false }
    -- end, { desc = "Telescope find old files globally" })
    -- vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "Telescope resume" })
    -- vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "Telescope document symbols" })
    -- vim.keymap.set("n", "<leader>fS", builtin.lsp_workspace_symbols, { desc = "Telescope workspace symbols" })

    vim.keymap.set("n", "<leader>en", function()
      require("telescope.builtin").find_files {
        cwd = vim.fn.stdpath "config",
      }
    end)
    vim.keymap.set("n", "<leader>ew", function()
      require("telescope.builtin").find_files {
        cwd = "~/.config/wezterm"
      }
    end)
    vim.keymap.set("n", "<leader>ep", function()
      require("telescope.builtin").find_files {
        ---@diagnostic disable-next-line: param-type-mismatch
        cwd = vim.fs.joinpath(vim.fn.stdpath "data", "lazy"),
      }
    end)
  end,
}
