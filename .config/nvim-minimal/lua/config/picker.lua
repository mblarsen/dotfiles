local M = {}

function M.setup(fun_map)
  local map = function(mode, keymap, func, opts)
    if func ~= nil then
      vim.keymap.set(mode, keymap, func, opts)
    end
  end

  map("n", "<leader>en", fun_map.neovim_files, { desc = "Neovim files" })
  map("n", "<leader>ep", fun_map.lazy_files, { desc = "Lazy files" })
  map("n", "<leader>fe", fun_map.explorer, { desc = "Explorer picker" })

  map("n", "<leader><leader>", fun_map.buffers, { desc = "Buffers picker" })

  map("n", "<leader>fO", fun_map.recent_all_files, { desc = "Find old files elsewhere" })
  map("n", "<leader>fS", fun_map.lsp_workspace_symbols, { desc = "LSP workspace symbols" })
  map("n", "<leader>ff", fun_map.files, { desc = "Find files" })
  map("n", "<leader>fl", fun_map.lines, { desc = "Find lines" })
  map("n", "<leader>fg", fun_map.grep, { desc = "Live grep files" })
  map("n", "<leader>fw", fun_map.grep_word, { desc = "Grep word in project" })
  map("n", "<leader>fn", fun_map.notifications, { desc = "Show all notifications" })
  map("n", "<leader>fo", fun_map.recent_project_files, { desc = "Find old files in projects" })
  map("n", "<leader>fp", fun_map.pickers, { desc = "Pick pickers" })
  map("n", "<leader>fr", fun_map.resume, { desc = "Picker resume" })
  map("n", "<leader>fs", fun_map.lsp_symbols, { desc = "LSP document symbols" })
  map("n", "<leader>ft", fun_map.tags, { desc = "Find tags" })
  map("n", "<leader>fG", fun_map.git_status, { desc = "Git status" })
  map("n", "<leader>fvL", fun_map.git_log_line, { desc = "Git log line" })
  map("n", "<leader>fvb", fun_map.git_branches, { desc = "Git branches" })
  map("n", "<leader>fvf", fun_map.git_files, { desc = "Git files" })
  map("n", "<leader>fvl", fun_map.git_log_file, { desc = "Git log file" })
end

return M
