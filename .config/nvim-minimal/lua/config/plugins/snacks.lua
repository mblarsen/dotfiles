local style = "compact"

return {
  "folke/snacks.nvim",
  priority = 1000,
  ---@type snacks.Config
  opts = {
    explorer = { enabled = true },
    image = { enabled = true },
    indent = {
      enabled = true,
      chunk = {
        -- highlight current chunk
        enabled = false,
      },
    },
    input = { enabled = true },
    notifier = { enabled = true, style = style },
    rename = { enabled = true },
    statuscolumn = {
      enabled = true,
      folds = {
        -- show open folds
        open = true,
      },
    },
    zen = { enabled = true },
    --
    words = { enabled = false },
    bigfile = { enabled = false },
    quickfile = { enabled = false },
    scroll = { enabled = false },
  },
  config = function(_, opts)
    require("snacks").setup(opts)

    vim.keymap.set("n", "<leader>zz", require("snacks").zen.zoom, { desc = "Snacks : Zen maximize window" })

    -- picker keymaps

    local builtin = Snacks.picker
    vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "Snacks : Buffers picker" })
    vim.keymap.set("n", "<leader>fe", builtin.explorer, { desc = "Snacks : Explorer picker" })
    vim.keymap.set("n", "<leader>ff", builtin.files, { desc = "Snacks : Find files" })
    vim.keymap.set("n", "<leader>fl", builtin.lines, { desc = "Snacks : Find files" })
    vim.keymap.set("n", "<leader>fg", builtin.grep, { desc = "Snacks : Live grep" })
    vim.keymap.set("n", "<leader>fG", builtin.git_status, { desc = "Snacks : Git status" })
    vim.keymap.set("n", "<leader>fw", builtin.grep_word, { desc = "Snacks : Grep word" })
    vim.keymap.set("n", "<leader>fn", builtin.notifications, { desc = "Snacks : All notifications" })
    vim.keymap.set("n", "<leader>fo", function()
      builtin.recent {
        filter = {
          paths = { [vim.fn.getcwd()] = true },
        },
      }
    end, { desc = "Snacks : Find old files in projects" })
    vim.keymap.set("n", "<leader>fO", function()
      builtin.recent {
        filter = {
          paths = { [vim.fn.getcwd()] = false },
        },
      }
    end, { desc = "Snacks : Find old files elsewhere" })
    vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "Snacks : Picker resume" })
    vim.keymap.set("n", "<leader>fp", builtin.pickers, { desc = "Snacks : Pick pickers" })
    vim.keymap.set("n", "<leader>fs", builtin.lsp_symbols, { desc = "Snacks : LSP document symbols" })
    vim.keymap.set("n", "<leader>fS", builtin.lsp_workspace_symbols, { desc = "Snacks : LSP workspace symbols" })
    vim.keymap.set("n", "<leader>fvb", builtin.git_branches, { desc = "Snacks : Git branches" })
    vim.keymap.set("n", "<leader>fvf", builtin.git_files, { desc = "Snacks : Git files" })
    vim.keymap.set("n", "<leader>fvl", builtin.git_log_file, { desc = "Snacks : Git log file" })
    vim.keymap.set("n", "<leader>fvL", builtin.git_log_line, { desc = "Snacks : Git log line" })

    vim.keymap.set("n", "<leader>en", function()
      builtin.files {
        dirs = { vim.fn.stdpath "config" },
        hidden = true,
      }
    end, { desc = "Snacks : Neovim files" })
    vim.keymap.set("n", "<leader>ep", function()
      builtin.files {
        dirs = { vim.fs.joinpath(vim.fn.stdpath "data", "lazy") },
        hidden = true,
      }
    end, { desc = "Snacks : Lazy files" })

    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesActionRename",
      callback = function(event)
        Snacks.rename.on_rename_file(event.data.from, event.data.to)
      end,
    })
  end,
}
