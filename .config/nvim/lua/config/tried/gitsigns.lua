local on_attach = require("autocommands").on_attach

return {
  "lewis6991/gitsigns.nvim",
  -- mini.diff seems to cover most of what I need so disabled
  -- only use [h ]h and ghp
  enabled = false,
  event = "BufRead",
  config = function()
    local gs = require "gitsigns"
    require("gitsigns").setup {
      attach_to_untracked = false,
      current_line_blame = false,
    }
    on_attach(function(buf)
      local opts = { buffer = buf }
      vim.keymap.set("n", "ghs", gs.stage_hunk, opts)
      vim.keymap.set("n", "ghr", gs.reset_hunk, opts)
      vim.keymap.set("v", "ghs", function()
        gs.stage_hunk { vim.fn.line ".", vim.fn.line "v" }
      end, opts)
      vim.keymap.set("v", "ghr", function()
        gs.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
      end, opts)
      vim.keymap.set("n", "ghS", gs.stage_buffer, opts)
      vim.keymap.set("n", "ghu", gs.undo_stage_hunk, opts)
      vim.keymap.set("n", "ghR", gs.reset_buffer, opts)
      vim.keymap.set("n", "ghp", gs.preview_hunk, opts)
      vim.keymap.set("n", "ghb", function()
        gs.blame_line { full = true }
      end, opts)
      vim.keymap.set("n", "gtb", gs.toggle_current_line_blame, opts)
      vim.keymap.set("n", "ghd", gs.diffthis, opts)
      vim.keymap.set("n", "ghD", function()
        gs.diffthis "~"
      end, opts)
      vim.keymap.set("n", "gtd", gs.toggle_deleted, opts)
      vim.keymap.set("n", "]h", gs.next_hunk, opts)
      vim.keymap.set("n", "[h", gs.prev_hunk, opts)
      vim.keymap.set("o", "ih", ":<C-U>Gitsigns select_hunk<CR>", opts)
      vim.keymap.set("x", "ih", ":<C-U>Gitsigns select_hunk<CR>", opts)
    end)
  end,
}
