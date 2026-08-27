---
--- options
---

vim.g.mapleader = " "
vim.o.laststatus = 2
vim.o.number = true
vim.o.relativenumber = true
vim.o.showmode = false
vim.o.signcolumn = "yes"
vim.o.swapfile = false
vim.o.tabstop = 4
vim.o.termguicolors = true
vim.o.winborder = "single"
vim.o.wrap = false

vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE" })
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE" })

vim.opt.shortmess:append {
  S = true, -- disable search count like [1/3]
  W = true, -- disable written message
  I = true, -- disable intro message
  C = true, -- disable completion messages like pattern not found
  c = true, -- disable completion messages like match 1 of 2
  F = true, -- disable file messages that trigger hit-enter
}

--
-- diagnostics
--

vim.diagnostic.config {
  severity_sort = true,
  update_in_insert = true,
  float = {
    focus = true,
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
-- completion
--

vim.opt.completeopt = {
  "menuone",  -- show the menu even if there's only one match
  "popup",    -- use a popup menu for completion
  "fuzzy",    -- use fuzzy matching
  "noinsert", -- do not insert text until the user selects an item
  "noselect", -- do not select the first item automatically
  "preview",  -- show a preview of the selected item
}

--
-- keymaps
--

local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  vim.keymap.set(mode, lhs, rhs, opts)
end

local function clear_search_mark_and_highlight()
  vim.cmd "normal! `s"
  vim.cmd.delm "s"
  vim.cmd.nohlsearch()
end

map("n", "<esc>", "<cmd>nohls|delm s<cr>")
map("n", "ss", "ms:s/\\v", { desc = "Search and replace in line" })
map("n", "SS", "ms:%s/\\v", { desc = "Search and replace in file" })
map("n", "sw", 'ms"wyiw:let @/=@w<cr>n``cgn', { desc = "Search and replace word on cursor" })
map("n", "/", "ms/", { noremap = true, desc = "Forward search" })
map("n", "?", "ms?", { noremap = true, desc = "Backward search" })
map("n", "*", "ms*", { noremap = true, desc = "Search for forward word under the cursor" })
map("n", "#", "ms#", { noremap = true, desc = "Search for backward word under the cursor" })
map("n", "`s", clear_search_mark_and_highlight, { desc = "Jumpt to location before search" })
map("n", "'s", clear_search_mark_and_highlight, { desc = "Jumpt to location before search" })
map("n", "n", "<Cmd>call HiSearch('n')<CR>zz", { noremap = true, silent = true, desc = "Search highlight forward" })
map("n", "N", "<Cmd>call HiSearch('N')<CR>zz", { noremap = true, silent = true, desc = "Search highlight backward" })
map("i", "<cr>", "<c-]><c-g>u<cr>", { noremap = true, desc = "More granular undo" })
map("n", "td", function() vim.diagnostic.open_float() end, { desc = "Pop-up diagnostics float" })

--
-- plugins
--

local plugins = {
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
  { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },

  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/elanmed/quickfix-preview.nvim" },
  { src = "https://github.com/Chaitanyabsprip/fastaction.nvim" },
  { src = "https://github.com/stevearc/conform.nvim" },
  { src = "https://github.com/azabiong/vim-highlighter" },
  { src = "https://github.com/nvim-mini/mini.nvim",                      branch = "stable" },

  { src = "https://github.com/wakatime/vim-wakatime" },

  ---

  { src = "https://github.com/samueljoli/hurl.nvim" },
  { src = "https://github.com/Chmarax/herdr-nvim" },
}

local function setup_mini()
  require "mini.icons".setup()

  local mini_diff = require "mini.diff"

  mini_diff.setup {
    mappings = {
      goto_first = "",
      goto_prev = "",
      goto_next = "",
      goto_last = "",
    },
  }

  local function goto_hunk(direction)
    return function()
      if mini_diff.get_buf_data() ~= nil then
        mini_diff.goto_hunk(direction)
      end
    end
  end

  map("n", "[H", goto_hunk("first"), { desc = "First hunk" })
  map("n", "[h", goto_hunk("prev"), { desc = "Previous hunk" })
  map("n", "]h", goto_hunk("next"), { desc = "Next hunk" })
  map("n", "]H", goto_hunk("last"), { desc = "Last hunk" })

  require "mini.pick".setup({
    mappings = {},
    options = {
      content_from_bottom = true,
      use_cache = true,
    },
  })
  require "mini.ai".setup({ custom_textobjects = {} })
  require "mini.basics".setup {
    autocommands = {
      basic = true,
    },
    options = {
      basic = true,
      extra_ui = true,
      win_borders = "dot",
    },
    mappings = {
      basic = true,
      option_toggle_prefix = [[yo]],
    },
    silent = false,
  }
  require('mini.cmdline').setup {}
  require "mini.files".setup {
    mappings = {
      go_in_plus = "<cr>",
    },
  }
  map("n", "<c-e>", function()
    if not MiniFiles.close() then
      require("mini.files").open(vim.api.nvim_buf_get_name(0))
    end
  end, { desc = "Mini.files: Toggle" })
  require "mini.git".setup()
  require "mini.surround".setup {}
  require "mini.completion".setup {}
end

local function configure_quickfix()
  vim.g.quickfix_preview = {
    -- defaults:
    open_preview_win_opts = {
      style = "minimal",
      split = "right",
      width = math.floor(vim.o.columns / 2),
    },
    preview_win_opts = {
      cursorline = true,
      number = true,
    }
  }

  vim.api.nvim_create_autocmd({ "FileType", }, {
    pattern = "qf",
    callback = function()
      vim.keymap.set("n", "p", "<Plug>QuickfixPreviewToggle", { buffer = true, })
    end,
  })
end

local function configure_code_actions()
  require "fastaction".setup {
    dismiss_keys = { "<c-c>", "<c-e>", "q" },
    brackets = { "", "" },
    popup = {
      title = false,
      border = "rounded",
      highlight = {
        title = "@keyword",
        key = "@keyword.debug",
        source = "CursorLineSign",
      },
    },
    priority = {
      lua = {
        { key = "d", pattern = "disable diagnostics on this line",     order = 1 },
        { key = "i", pattern = "disable diagnostics in this file",     order = 2 },
        { key = "s", pattern = "disable diagnostics in the workspace", order = 3 },
      },
    },
  }
  map("n", "ta", function()
    require "fastaction".code_action {
      select_first = true,
      notify = true,
    }
  end, { noremap = true, silent = true, desc = "Apply first code action" })
  map({ "n", "x" }, "tc", function()
    require("fastaction").code_action()
  end, { noremap = true, silent = true, desc = "Show code actions" })
end

local function configure_picker()
  local function picker_setup(fun_map)
    local function map_if(mode, keymap, func, opts)
      if func ~= nil then
        map(mode, keymap, func, opts)
      end
    end

    map_if("n", "<leader>en", fun_map.neovim_files, { desc = "Neovim files" })
    map_if("n", "<leader>ep", fun_map.lazy_files, { desc = "Lazy files" })
    map_if("n", "<leader>ec", fun_map.config_files, { desc = "Config files" })
    map_if("n", "<leader>fe", fun_map.explorer, { desc = "Explorer picker" })

    map_if("n", "<leader><leader>", fun_map.buffers, { desc = "Buffers picker" })

    map_if("n", "<leader>fO", fun_map.recent_all_files, { desc = "Find old files elsewhere" })
    map_if("n", "<leader>fS", fun_map.lsp_workspace_symbols, { desc = "LSP workspace symbols" })
    map_if("n", "<leader>ff", fun_map.files, { desc = "Find files" })
    map_if("n", "<leader>fl", fun_map.lines, { desc = "Find lines" })
    map_if("n", "<leader>fh", fun_map.help, { desc = "Find help" })
    map_if("n", "<leader>fg", fun_map.grep, { desc = "Live grep files" })
    map_if("n", "<leader>fw", fun_map.grep_word, { desc = "Grep word in project" })
    map_if("n", "<leader>fm", fun_map.maps, { desc = "Find maps" })
    map_if("n", "<leader>fn", fun_map.notifications, { desc = "Show all notifications" })
    map_if("n", "<leader>fo", fun_map.recent_project_files, { desc = "Find old files in projects" })
    map_if("n", "<leader>fp", fun_map.pickers, { desc = "Pick pickers" })
    map_if("n", "<leader>fr", fun_map.resume, { desc = "Picker resume" })
    map_if("n", "<leader>fs", fun_map.lsp_symbols, { desc = "LSP document symbols" })
    map_if("n", "<leader>ft", fun_map.tags, { desc = "Find tags" })
    map_if("n", "<leader>fG", fun_map.git_status, { desc = "Git status" })
    map_if("n", "<leader>fvL", fun_map.git_log_line, { desc = "Git log line" })
    map_if("n", "<leader>fvb", fun_map.git_branches, { desc = "Git branches" })
    map_if("n", "<leader>fvf", fun_map.git_files, { desc = "Git files" })
    map_if("n", "<leader>fvl", fun_map.git_log_file, { desc = "Git log file" })
  end

  picker_setup({
    files = require "mini.pick".builtin.files,
    explorer = require "mini.extra".pickers.explorer,
    maps = require "mini.extra".pickers.keymaps,
    git_files = function() require "mini.extra".pickers.git_files { scope = "modified" } end,
    recent_project_files = function()
      require "mini.extra".pickers.oldfiles({ current_dir = true })
    end,
    recent_all_files = function()
      require "mini.extra".pickers.oldfiles({ current_dir = false })
    end,
    buffers = require "mini.pick".builtin.buffers,
    resume = require "mini.pick".builtin.resume,
    grep = require "mini.pick".builtin.grep_live,
    help = require "mini.pick".builtin.help,
    lsp_symbols = function()
      require "mini.extra".pickers.lsp({ scope = "document_symbol" })
    end,
    lsp_workspace_symbols = function()
      require "mini.extra".pickers.lsp({ scope = "workspace_symbol" })
    end,
  })
end

local function configure_formatting()
  require("conform").setup({
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    },
  })
end

local function configure_tresitter()
  local treesitter = require("nvim-treesitter")

  local function select_node(target)
    return function()
      vim.treesitter.select(target, vim.v.count1)
    end
  end

  treesitter.install {
    "go",
    "gleam",
    "roc",
    "javascript",
    "json",
    "python",
    "rust",
    "toml",
    "tsx",
    "typescript",
    "yaml",
  }

  vim.api.nvim_create_autocmd("FileType", {
    pattern = {
      "go",
      "gleam",
      "roc",
      "javascript",
      "javascriptreact",
      "json",
      "jsonc",
      "jsonl",
      "python",
      "rust",
      "toml",
      "typescript",
      "typescriptreact",
      "yaml",
    },
    callback = function(args)
      vim.treesitter.start(args.buf)

      vim.keymap.set("n", "<cr>", select_node("parent"), {
        buffer = args.buf,
        desc = "Start Treesitter selection",
      })
      vim.keymap.set("x", "<cr>", select_node("parent"), {
        buffer = args.buf,
        desc = "Grow Treesitter selection",
      })
      vim.keymap.set("x", "<bs>", select_node("child"), {
        buffer = args.buf,
        desc = "Shrink Treesitter selection",
      })
    end,
  })
end

vim.pack.add(plugins, { confirm = false })

require("mason").setup()
require("mason-lspconfig").setup()
vim.lsp.enable("gleam")
require('mason-tool-installer').setup {
  ensure_installed = {
    "lua_ls", -- lua
    "tsgo",   -- typescript
    "gopls",  -- go
    "ty",     -- python
    "ruff",   -- python
    "jsonls", -- json
    "yamlls", -- yaml
    "taplo",  -- toml
    "gleam",
  },
  auto_update = true,
  debounce_hours = 24,
}

setup_mini()

configure_tresitter()
configure_picker()
configure_code_actions()
configure_quickfix()
configure_formatting()

require("hurl").setup()
-- require("herder-nvim").setup()

vim.cmd [[colorscheme catppuccin]]
