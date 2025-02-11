local opt = vim.opt

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true

-- folding
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldlevelstart = 99

opt.clipboard = ""

-- numbers are nice, relatively
opt.number = true
opt.relativenumber = true

opt.termguicolors = true
opt.breakindent = true
opt.breakindentopt = "shift:2"

--  S	do not show search count message when searching [1/3]
opt.shortmess:append "S"

-- don't show mode under status line
opt.showmode = false

-- list chars
opt.list = true
opt.listchars = {
  nbsp = "▬",
  tab = "  ",
  trail = "·",
}

-- blinking cursor
opt.guicursor =
  "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-cursor/lcursor,sm:block-blinkwait175-blinkoff150-blinkon175"

opt.timeoutlen = 500 -- default: 1000

-- show statusline
opt.laststatus = 2 -- 1 = off, 2 = local, 3 = global

-- diagnostic
vim.diagnostic.config({
  virtual_lines = {
    current_line = true,
    severity = vim.diagnostic.severity.ERROR
  },
  virtual_text = false,
})
