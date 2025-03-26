local M = {}

M.virtual_text = {
  current_line = true,
}
M.virtual_text_when_on = {
  current_line = true,
}

M.virtual_lines = false
M.virtual_lines_when_on = {
  current_line = true,
}

vim.diagnostic.config {
  update_in_insert = false,
  float = { focusable = true, source = true },
  virtual_lines = M.virtual_lines,
  virtual_text = M.virtual_text,
  jump = {
    severity = { min = vim.diagnostic.severity.INFO },
  },
  signs = {
    severity = { min = vim.diagnostic.severity.ERROR },
    text = {
      [vim.diagnostic.severity.ERROR] = "●",
      [vim.diagnostic.severity.WARN] = "●",
      [vim.diagnostic.severity.INFO] = "●",
      [vim.diagnostic.severity.HINT] = "－",
    },
  },
  underline = true,
}

return M
