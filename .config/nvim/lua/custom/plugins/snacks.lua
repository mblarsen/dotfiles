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
  ---@type snacks.Config
  opts = {
    input = { enabled = true },
    notifier = { enabled = true, style = style },
    picker = { layout = "ivy" },
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

    -- picker keymaps

    local builtin = Snacks.picker
    vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "Snack picker buffers" })
    vim.keymap.set("n", "<leader>fe", builtin.explorer, { desc = "Snack picker explorer" })
    vim.keymap.set("n", "<leader>ff", builtin.files, { desc = "Snack picker find files" })
    vim.keymap.set("n", "<leader>fg", builtin.grep, { desc = "Snack picker live grep" })
    vim.keymap.set("n", "<leader>fG", builtin.git_status, { desc = "Snack picker git status" })
    vim.keymap.set("n", "<leader>fw", builtin.grep_word, { desc = "Snack picker grep word" })
    vim.keymap.set("n", "<leader>fh", builtin.help, { desc = "Snack picker help tags" })
    vim.keymap.set("n", "<leader>fn", builtin.notifications, { desc = "Snack picker notifications" })
    vim.keymap.set("n", "<leader>fo", function()
      builtin.recent {
        filter = {
          paths = { [vim.fn.getcwd()] = true },
        },
      }
    end, { desc = "Snack picker find old files" })
    vim.keymap.set("n", "<leader>fO", function()
      builtin.recent {
        filter = {
          paths = { [vim.fn.getcwd()] = false },
        },
      }
    end, { desc = "Snack picker find old files" })
    -- vim.keymap.set("n", "<leader>fO", function()
    --   builtin.oldfiles { cwd_only = false }
    -- end, { desc = "Snack picker find old files globally" })
    vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "Snack picker resume" })
    vim.keymap.set("n", "<leader>fp", builtin.pickers, { desc = "Snack picker pickers" })
    vim.keymap.set("n", "<leader>fs", builtin.lsp_symbols, { desc = "Snack picker document symbols" })
    vim.keymap.set("n", "<leader>fS", builtin.lsp_workspace_symbols, { desc = "Snack picker workspace symbols" })
    vim.keymap.set("n", "<leader>fvb", builtin.git_branches, { desc = "Snack picker git branches" })
    vim.keymap.set("n", "<leader>fvf", builtin.git_files, { desc = "Snack picker git files" })
    vim.keymap.set("n", "<leader>fvl", builtin.git_log_file, { desc = "Snack picker git log file" })
    vim.keymap.set("n", "<leader>fvL", builtin.git_log_line, { desc = "Snack picker git log line" })

    vim.keymap.set("n", "<leader>en", function()
      builtin.files {
        dirs = { vim.fn.stdpath "config" },
        hidden = true,
      }
    end)
    vim.keymap.set("n", "<leader>ew", function()
      builtin.files {
        dirs = { "~/.config/wezterm" },
        hidden = true,
      }
    end)
    vim.keymap.set("n", "<leader>ep", function()
      builtin.files {
        dirs = { vim.fs.joinpath(vim.fn.stdpath "data", "lazy") },
        hidden = true,
      }
    end)
  end,
}
