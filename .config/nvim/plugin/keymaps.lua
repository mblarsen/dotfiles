local diagnostic_config = require "custom.diagnostic"

local set = vim.keymap.set

set("t", "<Esc>", "<C-\\><C-n><C-w>p", { desc = "Easy exit terminal" })
-- set("n", "<leader>x", "<cmd>bd<CR>", { desc = "Close the current buffer" })
-- set("n", "<leader>X", "<cmd>bd!<CR>", { desc = "Force close the current buffer" })
set("n", "<leader>W", "<cmd>w | bd<CR>", { desc = "Write buffer and close it" })
set("n", "<esc>", "<cmd>nohls<cr>")
set("n", "<leader>vp", "`[v`]", { desc = "Select last paste" })
set("n", "<bs>", "^", { desc = "Goes to first non-space character on the line" })
set("n", "ss", ":s/\\v", { desc = "Search and replace in line" })
set("n", "SS", ":%s/\\v", { desc = "Search and replace in file" })
set("n", "<C-n>", '"wyiw:let @/=@w<cr>n``cgn', { desc = "Search and replace word on cursor" })
-- old and simpler implementation of search and replace
-- set("n", "<C-n>", "*``cgn", { desc = "Search and replace word on cursor" })
set("v", "<C-n>", '"hy:let @/=@h<cr>cgn', { desc = "Change selection inline one by one" })
set("v", "<C-r>", '"hy:%s/\\v<C-r>h//g<left><left>', { desc = "Change selection with regexp" })
set("n", "<leader>yf", ":%y<cr>", { desc = "Yank file" })
set("i", "jj", "<esc>", { desc = "Easy ESCape from intert mode" })
set("i", "kk", "<esc>", { desc = "Easy ESCape from intert mode" })
set("i", "hh", "<esc>", { desc = "Easy ESCape from intert mode" })

set("n", "gti", function()
  local inlay_hint = vim.lsp.inlay_hint
  local filter = { bufnr = 0 }
  inlay_hint.enable(not inlay_hint.is_enabled(filter), filter)
end, { desc = "Toggle inlay hint" })

local function toggle_virtual_lines()
  local diagnostics_virtual_lines = not vim.diagnostic.config().virtual_lines
  vim.diagnostic.config {
    virtual_lines = diagnostics_virtual_lines and diagnostic_config.virtual_lines_when_on or false,
    virtual_text = not diagnostics_virtual_lines and diagnostic_config.virtual_text_when_on or false,
  }
end

vim.keymap.set("n", "gtl", toggle_virtual_lines, { desc = "Toggle diagnostic virtual lines" })
