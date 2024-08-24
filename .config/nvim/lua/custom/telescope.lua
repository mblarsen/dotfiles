local actions = require "telescope.actions"
local builtin = require "telescope.builtin"

-- require("telescope").load_extension "gh"
-- require("telescope").load_extension "terraform_doc"

require("telescope").setup {
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
      },
    },
    layout_config = {
      horizontal = {
        width = 0.95,
        height = 0.8,
      },
    },
  },
  pickers = {
    find_files = {
      theme = "dropdown",
    },
    oldfiles = {
      theme = "dropdown",
    },
    buffers = {
      theme = "dropdown",
    },
  },
}
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fG", builtin.git_status, {})
vim.keymap.set("n", "<leader><leader>", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
vim.keymap.set("n", "<leader>fo", builtin.oldfiles, {})
vim.keymap.set("n", "<space>/", builtin.current_buffer_fuzzy_find, {})

vim.keymap.set("n", "<leader>td", "<CMD>Telescope terraform_doc full_name=hashicorp/aws<CR>", {})
