local M = {}

function M.setup()
  local builtin = Snacks.picker

  local pickers = vim.tbl_extend("force", {}, builtin, {
    -- FIXME: builtin pickers are first loaded when one of them are accessed
    files = builtin.files,
    recent_project_files = function()
      builtin.recent { filter = { paths = { [vim.fn.getcwd()] = true } } }
    end,
    recent_all_files = function()
      builtin.recent { filter = { paths = { [vim.fn.getcwd()] = false } } }
    end,
    config_files = function()
      builtin.files { dirs = { vim.fn.expand "~/.config" }, hidden = true }
    end,
    neovim_files = function()
      builtin.files { dirs = { vim.fn.stdpath "config" }, hidden = true }
    end,
    lazy_files = function()
      builtin.files { dirs = { vim.fs.joinpath(vim.fn.stdpath "data", "lazy") }, hidden = true }
    end,
  })

  require("config.picker").setup(pickers)
end

return M
