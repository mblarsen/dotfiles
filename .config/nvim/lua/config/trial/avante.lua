return {
  "yetone/avante.nvim",
  enabled = true,
  cond = true,
  event = "VeryLazy",
  version = false,
  build = "make",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "MeanderingProgrammer/render-markdown.nvim", -- config in ../optional/render-markdown.lua
    -- "ravitemer/mcphub.nvim",
    "folke/snacks.nvim", -- for input provider snacks
    "echasnovski/mini.nvim", -- or echasnovski/mini.icons
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
  },
  opts = {
    debug = false,
    mode = "legacy",
    -- mode = "agentic",
    provider = "gemini", -- openai, gemini
    providers = {
      openai = {
        model = "gpt-4o",
      },
      gemini = {
        -- model = "gemini-2.5-pro-preview-05-06",
        model = "gemini-2.5-pro-preview-06-05",
      },
    },
    -- Features Section
    features = {
      web_search = true,
      project_context = false,
      file_search = true,
    },
    --- Behaviour Tuning
    behaviour = {
      auto_apply_diff_after_generation = false, -- manual diff approval
      auto_approve_tool_permissions = { "glob", "grep", "ls", "view_file" },
      auto_focus_sidebar = true,
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_suggestions = false,
      cursor_planning_mode = false, -- plan-apply workflow
      enable_token_counting = true, -- see real-time usage
      minimize_diff = true, -- disable full context diffs
      support_paste_from_clipboard = false,
    },
    -- Tools Configuration
    tools = {
      disabled_tools = { "git_commit" },
      -- disabled_tools = { 'python', 'replace_in_file' },
      web_search = {
        provider = "tavily",
        max_results = 5,
        include_answer = true,
        timeout = 15000,
      },
      -- rag_service = {
      --   enabled = true,
      --   provider = "claude",
      --   llm_model = "claude-3-7-sonnet",
      --   embed_model = "nomic-embed-text",
      --   host_mount = vim.env.HOME,
      -- },
      -- Alternative Gemini RAG configuration (disabled by default)
      -- To use, change the provider in rag_service to "gemini"
      -- gemini_rag = {
      --   provider = "gemini",
      --   llm_model = "gemini-2.5-pro-preview-05-06",
      --   embed_model = "vertex-embed-text-2", -- Latest Google embedding model as of 2025
      --   chunk_size = 4096, -- Enhanced chunk size for better context retention
      --   chunk_overlap = 512, -- Increased overlap for improved context coherence
      --   hybrid_search = true, -- Enables both semantic and keyword search
      --   reranking = true, -- Post-processing to improve result relevance
      --   max_sources = 15, -- Increased source limit for more comprehensive context
      -- },
      -- mcp = { enabled = true },
    },
    web_search_engine = {
      provider = "tavily",
      api_key = os.getenv "TAVILY_API_KEY",

      -- Additional settings:
      max_results = 5, -- Number of search results to retrieve (default: 5)
      include_answer = true, -- Include Tavily's summarized answer (default: true)
      include_images = false, -- Include images in search results (default: false)
      search_depth = "advanced", -- "basic" or "advanced" search depth (default: "basic")
      include_domains = {}, -- Array of domains to prioritize in search results
      exclude_domains = {}, -- Array of domains to exclude from search results
      timeout = 15000, -- Timeout in milliseconds (default: 15000)
      -- For specialized searches:
      search_type = "search", -- Can be "search" or "passage" (default: "search")
      search_bm25 = false, -- Enable BM25 vector search (default: false)
    },
    -- Persistent History
    history = {
      storage_path = vim.fn.stdpath "state" .. "/avante",
      max_tokens = 8192,
      carried_entry_count = 10,
    },
    windows = {
      width = 50,
      sidebar_header = {
        enabled = false,
        align = "left",
        rounded = "true",
      },
      input = {
        prefix = "» ",
      },
      edit = {
        border = "rounded",
        start_insert = true, -- Start insert mode when opening the edit window
      },
      ask = {
        border = "rounded",
        floating = false,
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
    ---@type avante.Config
  end,
}
