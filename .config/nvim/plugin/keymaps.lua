local set = vim.keymap.set

set("t", "<Esc>", "<C-\\><C-n><C-w>p", { desc = "Easy exit terminal" })
set("n", "<leader>x", "<cmd>bd<CR>", { desc = "Close the current buffer" })
set("n", "<leader>X", "<cmd>bd!<CR>", { desc = "Force close the current buffer" })
set("n", "<leader>W", "<cmd>w | bd<CR>", { desc = "Write buffer and close it" })
set("n", "[c", "<cmd>cnext<CR>", { desc = "Go to next quixfix entry" })
set("n", "]c", "<cmd>cprev<CR>", { desc = "Go to previous quixfix entry" })
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

set("n", "gti", function()
  local inlay_hint = vim.lsp.inlay_hint
  local filter = { bufnr = 0 }
  inlay_hint.enable(not inlay_hint.is_enabled(filter), filter)
end, { desc = "Toggle inlay hint" })

set("n", "<leader>fn", function()
  local file = vim.fn.expand "%:t"
  local path = vim.fn.expand "%:h"
  vim.notify(
    "path: " .. path .. "\nfile: " .. file,
    vim.log.levels.INFO,
    { title = "Current file", timeout = 10000, id = "currentfile" }
  )
end, { desc = "Notify current file name", noremap = true, silent = true })
