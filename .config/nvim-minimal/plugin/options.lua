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

--
-- fold options
--
local function fold_virt_text(result, s, lnum, coloff)
  if not coloff then
    coloff = 0
  end
  local text = ""
  local hl
  for i = 1, #s do
    local char = s:sub(i, i)
    local hls = vim.treesitter.get_captures_at_pos(0, lnum, coloff + i - 1)
    local _hl = hls[#hls]
    if _hl then
      local new_hl = "@" .. _hl.capture
      if new_hl ~= hl then
        table.insert(result, { text, hl })
        text = ""
        hl = nil
      end
      text = text .. char
      hl = new_hl
    else
      text = text .. char
    end
  end
  table.insert(result, { text, hl })
end

function _G.custom_foldtext()
  local start = vim.fn.getline(vim.v.foldstart):gsub("\t", string.rep(" ", vim.o.tabstop))
  local end_str = vim.fn.getline(vim.v.foldend)
  local end_ = vim.trim(end_str)
  local result = {}
  fold_virt_text(result, start, vim.v.foldstart - 1)
  table.insert(result, { " ... ", "Delimiter" })
  fold_virt_text(result, end_, vim.v.foldend - 1, #(end_str:match("^(%s+)") or ""))
  return result
end

vim.opt.foldtext = "v:lua.custom_foldtext()"

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client and client:supports_method('textDocument/foldingRange') then
        local win = vim.api.nvim_get_current_win()
        vim.wo[win][0].foldmethod = 'expr'
        vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
      end
    end,
})
vim.api.nvim_create_autocmd('LspDetach', { command = 'setl foldexpr<' })

opt.foldlevel = 99
