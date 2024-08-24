require "custom.snippets"

local cmp = require "cmp"

vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.shortmess:append "c"

local lspkind = require "lspkind"

cmp.setup {
  formatting = {
    expandable_indicator = true,
    fields = { "abbr", "kind", "menu" },
    format = lspkind.cmp_format {
      mode = "symbol_text",
      maxwidth = function()
        return math.floor(0.45 * vim.o.columns)
      end,
      ellipsis_char = "...",
      show_labelDetails = true,
    },
  },
  ---@diagnostic disable-next-line: undefined-field
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "path" },
    {
      name = "lazydev",
      group_index = 0, -- set group index to 0 to skip loading LuaLS completions
    },
  }, {
    { name = "buffer" },
  }),
  mapping = cmp.mapping.preset.insert {
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
    ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
    ["<C-e>"] = cmp.mapping.abort(),
    ["<C-y>"] = cmp.mapping(
      cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      },
      { "i", "c" }
    ),
  },
  performance = {
    max_view_entries = 75,
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

require("cmp_git").setup()
