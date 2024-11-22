local opt = vim.opt

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true

-- folding
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldlevelstart = 99
-- vim.g.markdown_folding = true

opt.clipboard = ""

-- numbers are nice, relatively
opt.number = true
opt.relativenumber = true

opt.termguicolors = true
opt.breakindent = true
opt.breakindentopt = "shift:2"

-- required by hardtime.nvim
opt.showmode = false

-- blinking cursor
opt.guicursor =
  "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-cursor/lcursor,sm:block-blinkwait175-blinkoff150-blinkon175"

opt.timeoutlen = 500 -- default: 1000

-- show statusline
opt.laststatus = 2 -- 1 = off, 2 = local, 3 = global

-- This makes is so that o doesn't add comment and a regular newline. Hitting enter will still insert a comment
opt.formatoptions:remove "o"
