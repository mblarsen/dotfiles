local set = vim.keymap.set

-- search
set("n", "<esc>", "<cmd>nohls|delm s<cr>")
set("n", "ss", "ms:s/\\v", { desc = "Search and replace in line" })
set("n", "SS", "ms:%s/\\v", { desc = "Search and replace in file" })
set("n", "sw", 'ms"wyiw:let @/=@w<cr>n``cgn', { desc = "Search and replace word on cursor" })
set("n", "/", "ms/", { noremap = true, desc = "Forward search" })
set("n", "?", "ms?", { noremap = true, desc = "Backward search" })
set("n", "*", "ms*", { noremap = true, desc = "Search for forward word under the cursor" })
set("n", "#", "ms#", { noremap = true, desc = "Search for backward word under the cursor" })
local function clear_search_mark_and_highlight()
  vim.cmd.delm "s"
  vim.cmd.nohlsearch()
end
set("n", "`s", function()
  vim.cmd "normal! `s"
  clear_search_mark_and_highlight()
end, { desc = "Jumpt to location before search" })
set("n", "'s", function()
  vim.cmd "normal! 's"
  clear_search_mark_and_highlight()
end, { desc = "Jumpt to location before search" })

-- flip 0 and ^
set("n", "0", "^", { desc = "Jumps to first non-space character on the line" })
set("n", "^", "0", { desc = "Jumps to beginning of line" })
set("n", "<bs>", "0", { desc = "Jumps to beginning of line" })

-- duplicate line(s) and comment
vim.keymap.set(
  "n",
  "ycc",
  '"yy" . v:count1 . "gcc\']p"',
  { remap = true, expr = true, desc = "Duplicate line(s) and comment" }
)

-- toggle fold when moving left at 0
set("n", "h", function()
  if vim.fn.col "." == 1 then
    ---@diagnostic disable-next-line: param-type-mismatch
    pcall(vim.cmd, "normal! zc") -- Close fold
  else
    vim.cmd "normal! h" -- Move left
  end
end, { desc = "Move left or close fold at column 0" })

-- toggle inlay hints
set("n", "gti", function()
  local inlay_hint = vim.lsp.inlay_hint
  local filter = { bufnr = 0 }
  inlay_hint.enable(not inlay_hint.is_enabled(filter), filter)
end, { desc = "LSP: Toggle inlay hint" })

-- toggle virtual lines and virtual text
local function toggle_virtual_lines()
  local diagnostics_virtual_lines = not vim.diagnostic.config().virtual_lines
  vim.diagnostic.config {
    virtual_lines = diagnostics_virtual_lines and { current_line = true } or false,
    virtual_text = not diagnostics_virtual_lines and { current_line = true } or false,
  }
end
vim.keymap.set("n", "gtl", toggle_virtual_lines, { desc = "Toggle diagnostic virtual lines" })

-- Hmm, why are these not already working
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "gD", vim.lsp.buf.type_definition, { desc = "Go to type definition" })

-- Lazy
vim.keymap.set("n", "<c-l>", "<cmd>Lazy<cr>", { desc = "Open Lazy" })
