local opt = vim.opt

opt.number = true
opt.relativenumber = true

opt.winborder = "rounded"

opt.shortmess:append {
  S = true, -- disable search count like [1/3]
  W = true, -- disable written message
  I = true, -- disable intro message
  C = true, -- disable completion messages like pattern not found
  c = true, -- disable completion messages like match 1 of 2
}

--
-- statusline
--
opt.laststatus = 2
opt.showmode = false
vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE" })
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE" })

--
-- diagnostic options
--
vim.diagnostic.config {
  severity_sort = true,
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
