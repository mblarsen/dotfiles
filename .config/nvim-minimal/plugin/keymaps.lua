local set = vim.keymap.set

set("n", "<esc>", "<cmd>nohls<cr>")
set("n", "ss", ":s/\\v", { desc = "Search and replace in line" })
set("n", "SS", ":%s/\\v", { desc = "Search and replace in file" })
set("n", "sw", '"wyiw:let @/=@w<cr>n``cgn', { desc = "Search and replace word on cursor" })

-- flip 0 and ^
set("n", "0", "^", { desc = "Jumps to first non-space character on the line" })
set("n", "^", "0", { desc = "Jumps to beginning of line" })

set("n", "gti", function()
  local inlay_hint = vim.lsp.inlay_hint
  local filter = { bufnr = 0 }
  inlay_hint.enable(not inlay_hint.is_enabled(filter), filter)
end, { desc = "Toggle inlay hint" })

local function toggle_virtual_lines()
  local diagnostics_virtual_lines = not vim.diagnostic.config().virtual_lines
  vim.diagnostic.config {
    virtual_lines = diagnostics_virtual_lines and { current_line = true } or false,
    virtual_text = not diagnostics_virtual_lines and { current_line = true } or false,
  }
end
vim.keymap.set("n", "gtl", toggle_virtual_lines, { desc = "Toggle diagnostic virtual lines" })
