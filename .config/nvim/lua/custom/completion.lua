require "custom.snippets"

local cmp = require "cmp"

vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.shortmess:append "c"

local lspkind = require "lspkind"

cmp.setup {
  -- performance = {
  --   debounce = 0, -- default is 60ms
  --   throttle = 0, -- default is 30ms
  --   -- max_view_entries = 75,
  -- },
  formatting = {
    expandable_indicator = true,
    fields = { "abbr", "kind", "menu" },
    format = lspkind.cmp_format {
      mode = "symbol_text",
      maxwidth = function()
        return math.floor(0.45 * vim.o.columns)
      end,
      ellipsis_char = "…",
      show_labelDetails = true,
    },
  },
  ---@diagnostic disable-next-line: undefined-field
  sources = cmp.config.sources({
    { name = "calc" },
    { name = "nvim_lsp" },
    { name = "dotenv"},
    { name = "path" },
    {
      name = "lazydev",
      group_index = 0, -- set group index to 0 to skip loading LuaLS completions
    },
  }, {
    { name = "buffer" },
  }),
  -- mapping = cmp.mapping.preset.insert {
  mapping = {
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
    ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
    ["<C-h>"] = cmp.mapping.scroll_docs(-4),
    ["<C-l>"] = cmp.mapping.scroll_docs(4),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<C-y>"] = cmp.mapping(
      cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      },
      { "i", "c" }
    ),
  },
  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body)
    end,
  },
}

cmp.setup.filetype("gitcommit", {
  ---@diagnostic disable-next-line: undefined-field
  sources = cmp.config.sources({
    { name = "git" },
  }, {
    { name = "buffer" },
  }),
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
      { name = 'cmdline' }
    }),
  matching = { disallow_symbol_nonprefix_matching = false }
})

 cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

require("cmp_git").setup()
