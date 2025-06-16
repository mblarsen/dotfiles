return {
  "ravitemer/mcphub.nvim",
  enabled = true,
  cond = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  build = "npm install -g mcp-hub@latest",
  opts = {
    auto_approve = true,
    debug = true,
    extensions = {
      avante = {
        make_slash_commands = true,
      },
    },
  },
  config = function(_, opts)
    require("mcphub").setup(opts)
    vim.keymap.set("n", "<leader>om", "<cmd>MCPHub<cr>", { desc = "Open MCPHub" })
  end,
}
