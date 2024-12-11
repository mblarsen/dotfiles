local style = "compact"

---@diagnostic disable-next-line: unused-local, unused-function
local function enable_simple_lsp_progress()
  vim.api.nvim_create_autocmd("LspProgress", {
    ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
    callback = function(ev)
      local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
      vim.notify(vim.lsp.status(), "info", {
        style = style,
        id = "lsp_progress",
        title = "LSP Progress",
        opts = function(notif)
          notif.icon = ev.data.params.value.kind == "end" and " "
            or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
        end,
      })
    end,
  })
end

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    input = { enabled = true },
    notifier = { enabled = true, style = style },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    zen = { enabled = true },
    --
    bigfile = { enabled = false },
    quickfile = { enabled = false },
    rename = { enabled = false },
    scroll = { enabled = false },
  },
  config = function(_, opts)
    require("snacks").setup(opts)

    enable_simple_lsp_progress()

    vim.keymap.set("n", "<leader>zz", require("snacks").zen.zoom, { desc = "Zen: maximize window" })
  end,
}
