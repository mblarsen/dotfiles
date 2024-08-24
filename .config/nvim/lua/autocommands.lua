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

    -- Enable completion triggered by <c-x><c-o>
    vim.bo[buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    local opts = { buffer = buf }
    vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { noremap = true })
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gr", function()
      require("trouble").open {
        auto_refresh = true,
        mode = "lsp_references",
      }
    end, opts)
    vim.keymap.set("n", "gi", function()
      require("trouble").open {
        auto_refresh = true,
        mode = "lsp_implementations",
      }
    end, opts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>fs", [[<cmd>FzfLua lsp_document_symbols<cr>]], opts)
    vim.keymap.set("n", "<leader>fS", [[<cmd>FzfLua lsp_workspace_symbols<cr>]], opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

    -- Disable diagnostic signs in the gutter
    vim.fn.sign_define("DiagnosticSignError", { text = "●" })
    vim.fn.sign_define("DiagnosticSignWarn", { text = "●" })
    vim.fn.sign_define("DiagnosticSignInfo", { text = "●" })
    vim.fn.sign_define("DiagnosticSignHint", { text = "●" })

    -- Rename action
    vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename)

    -- for each callback, call it with the event
    for _, cb in ipairs(on_attach_callbacks) do
      cb(buf, client, event)
    end

    -- vim.diagnostic.config { virtual_text = false }
    vim.diagnostic.config {
      update_in_insert = true,
      float = {
        focusable = true,
        -- header = "",
      },
    }
  end,
})

return M
