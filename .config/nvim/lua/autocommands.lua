local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local group = augroup("user", { clear = true })

local on_attach_callbacks = {}
local M = {}

M.on_attach = function(callback)
  table.insert(on_attach_callbacks, callback)
end

autocmd({ "LspAttach" }, {
  pattern = "*",
  group = group,
  callback = function(event)
    local buf = event.buf
    local client = vim.lsp.get_client_by_id(event.data.client_id)

    -- -- Enable completion triggered by <c-x><c-o>
    -- vim.bo[buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    local opts = { buffer = buf }
    vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { noremap = true })
    vim.keymap.set("n", "gD", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "grr", function()
      require("trouble").open {
        auto_refresh = true,
        mode = "lsp_references",
      }
    end, opts)
    vim.keymap.set("n", "gri", function()
      require("trouble").open {
        auto_refresh = true,
        mode = "lsp_implementations",
      }
    end, opts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

    -- Rename action
    vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename)

    -- for each callback, call it with the event
    for _, cb in ipairs(on_attach_callbacks) do
      if type(cb) == "function" then
        cb(buf, client, event)
      elseif type(cb) == "table" then
        print "cb is a table, cannot call it as a function"
      else
        print "cb is neither a table nor a function"
      end
    end

  end,
})

return M
