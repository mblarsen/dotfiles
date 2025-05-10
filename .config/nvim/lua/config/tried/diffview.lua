return {
  "sindrets/diffview.nvim",
  config = function ()
    vim.keymap.set('n', 'gtd', function()
      if next(require('diffview.lib').views) == nil then
        vim.cmd('DiffviewOpen')
      else
        vim.cmd('DiffviewClose')
      end
    end)
  end
}
