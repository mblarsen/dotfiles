local M = {}

function M.setup(user_override)
  local ok, builtin = pcall(require, "telescope.builtin")
  if not ok then
    return
  end

  require("config.picker").setup(vim.tbl_extend("force", builtin, {
    files = builtin.find_files,
    grep = builtin.live_grep,
    grep_word = builtin.grep_string,
    lsp_symbols = builtin.lsp_document_symbols,
    pickers = builtin.builtin,
    recent_project_files = function()
      builtin.oldfiles { cwd_only = true }
    end,
    recent_all_files = function()
      builtin.oldfiles {}
    end,
    neovim_files = function()
      builtin.find_files { cwd = vim.fn.stdpath "config", hidden = true }
    end,
    lazy_files = function()
      builtin.find_files { cwd = vim.fs.joinpath(vim.fn.stdpath "data", "lazy"), hidden = true }
    end,
  }, user_override or {}))
end

return M
