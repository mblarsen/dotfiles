return {
  "yetone/avante.nvim",
  enabled = true,
  event = "VeryLazy",
  version = false,
  build = "make",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    -- "ravitemer/mcphub.nvim",
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
  ---@type avante.Config
  opts = {
    ---@type avante.ProviderName
    provider = "openai",
    ---@type AvanteSupportedProvider
    openai = {
      model = "gpt-4o",
    },
    ---@type AvanteSupportedProvider
    gemini = {
      model = "gemini-2.5-pro-exp-03-25",
    },
    -- behaviour = {
    --   auto_suggestions = true, -- Experimental stage
    -- },
    mappings = {
      sidebar = {
        close_from_input = {
          normal = "<Esc>",
          insert = "<C-e>",
        },
      },
      suggestion = {
        accept = "<C-s>",
        next = "<C-n>",
        prev = "<C-p>",
        dismiss = "<C-e>",
      },
      submit = {
        normal = "<CR>",
        insert = "<C-s>",
      },
      cancel = {
        normal = { "<C-e>", "q" },
        insert = { "<C-e>" },
      },
    },
    selector = {
      provider = "snacks",
    },
    -- system_prompt = function()
    --   local hub = require("mcphub").get_hub_instance()
    --   ---@diagnostic disable-next-line: need-check-nil
    --   local prompts = hub:get_active_servers_prompt()
    --   return prompts
    -- end,
    -- custom_tools = function()
    --   return {
    --     require("mcphub.extensions.avante").mcp_tool(),
    --   }
    -- end,
    -- dual_boost = {
    --   enabled = false,
    --   first_provider = "gemini",
    --   second_provider = "openai",
    -- },
    -- disabled_tools = {
    --   "list_files",
    --   "search_files",
    --   "read_file",
    --   "create_file",
    --   "rename_file",
    --   "delete_file",
    --   "create_dir",
    --   "rename_dir",
    --   "delete_dir",
    --   "bash",
    -- },
  },
  config = function(_, opts)
    require("avante").setup(opts)
    vim.keymap.set("n", "<leader>ap", function()
      require("avante").current.sidebar.file_selector:open()
    end, { desc = "Open Avante file picker" })
  end,
}
