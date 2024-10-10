local fzf = require "fzf-lua"

fzf.setup {
  "borderless",
}

vim.keymap.set("n", "<leader>fr", fzf.resume, { desc = "Fzf resume" })

vim.keymap.set("n", "<leader>ff", fzf.files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", fzf.live_grep_glob, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fG", fzf.git_status, { desc = "Git status" })
vim.keymap.set("n", "<leader><leader>", fzf.buffers, { desc = "Find buffer" })
vim.keymap.set("n", "<leader>fh", fzf.helptags, { desc = "Search help" })
vim.keymap.set("n", "<leader>fo", fzf.oldfiles, { desc = "Find old file" })
vim.keymap.set("n", "<space>/", fzf.grep_curbuf, { desc = "Find buffer" })
