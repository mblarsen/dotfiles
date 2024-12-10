return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
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
      },
    }
    local builtin = require "telescope.builtin"
    vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "Telescope buffers" })
    vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
    vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "Telescope find old files" })
    vim.keymap.set("n", "<leader>fO", function()
      builtin.oldfiles { cwd_only = false }
    end, { desc = "Telescope find old files globally" })
    vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "Telescope resume" })
  end,
}
