local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.winborder = "rounded"

opt.shortmess:append "S" -- disable search count like [1/3]
opt.shortmess:append "c" -- disable completion messages

--
-- diagnostic options
--
vim.diagnostic.config {
  update_in_insert = false,
  float = { focusable = true, source = true },
  virtual_lines = false,
  virtual_text = false,
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

--
-- completion options
--
opt.completeopt = {
  "menuone",
  "popup",
  "fuzzy",
  "noinsert",
  "preview",
}
