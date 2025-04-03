local opt = vim.opt

opt.number = true
opt.relativenumber = true

opt.shortmess:append "S" -- disable search count like [1/3]
opt.shortmess:append "c" -- disable completion messages

--
-- statusline
--
opt.laststatus = 2
opt.showmode = false
vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE" })
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE" })
require("statusline").setup {}

--
-- diagnostic options
--
vim.diagnostic.config {
  update_in_insert = true,
  float = {
    focusable = true,
    source = true,
  },
  virtual_lines = false,
  virtual_text = {
    current_line = true,
  },
  jump = {
    severity = { min = vim.diagnostic.severity.INFO },
  },
  signs = {
    severity = { min = vim.diagnostic.severity.WARN },
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
  "noselect",
  "preview",
}
