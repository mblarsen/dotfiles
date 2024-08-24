local opt = vim.opt_local

opt.textwidth = 80
opt.wrap = true
opt.linebreak = true
opt.relativenumber = false
opt.conceallevel = 2

vim.keymap.set({ "i", "n" }, "g<CR>", "<Plug>(TodoneToggle)")
vim.keymap.set({ "i", "n" }, "g<BS>", "<Plug>(TodoneRemove)")
vim.keymap.set("n", "<leader>ft", "<Plug>(TodoneTelescope)")

local M = {}

M.HighlightAt = function()
  vim.cmd "highlight link Version @character"
  vim.cmd "highlight link Solution @character"
  vim.cmd "highlight link AtPre @character"
  vim.cmd "highlight link AtDomain @constant"
  vim.cmd "highlight link Important DiagnosticError"
  vim.fn.matchadd("Version", "v\\d\\+\\.\\d\\+.\\d\\+")
  vim.fn.matchadd("AtPre", "\\w\\+@")
  vim.fn.matchadd("AtDomain", "@\\w\\+")
  vim.fn.matchadd("AtDomain", "@\\w\\+\\.\\w\\+")
  vim.fn.matchadd("Solution", "\\(action\\|answer\\|outcome\\|result\\): ")
  vim.fn.matchadd("Solution", "\\(re\\)\\?solution: ")
  vim.fn.matchadd("Important", "\\!\\!\\?\\!\\? ")
end

M.HighlightAt()
