return {
  "vimpostor/vim-tpipeline",
  enabled = false,
  config = function()
    vim.g.tpipeline_statusline = "%t %M "
    vim.g.statusline = "%!tpipeline#stl#line()"
    -- vim.cmd [[
    -- set stl=%!tpipeline#stl#line()
    -- ]]
  end,
}
