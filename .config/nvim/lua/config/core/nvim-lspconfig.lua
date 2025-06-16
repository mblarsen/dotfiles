return {
  "mason-org/mason-lspconfig.nvim",
  enabled = true,
  dependencies = {
    "neovim/nvim-lspconfig",
    "mason-org/mason.nvim",
    "b0o/schemastore.nvim",
    "echasnovski/mini.nvim",
  },
  config = function()
    -- Set same capabilities on all servers
    vim.lsp.config("*", {
      capabilities = vim.tbl_deep_extend(
        "force",
        vim.lsp.protocol.make_client_capabilities(),
        require("blink.cmp").get_lsp_capabilities({
          -- textDocument = {
          --   completion = {
          --     completionItem = {
          --       commitCharactersSupport = true,
          --       deprecatedSupport = true,
          --       documentationFormat = { "markdown", "plaintext" },
          --       preselectSupport = true,
          --       -- insertReplaceSupport = true,
          --       labelDetailsSupport = true,
          --       snippetSupport = true,
          --       resolveSupport = {
          --         properties = {
          --           "documentation",
          --           "details",
          --           "additionalTextEdits",
          --         },
          --       },
          --     },
          --     contextSupport = true,
          --     dynamicRegistration = true,
          --   },
          -- },
        }, false)
      ),
    })

    -- Set up code folding where supported
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client:supports_method "textDocument/foldingRange" then
          local win = vim.api.nvim_get_current_win()
          vim.wo[win][0].foldmethod = "expr"
          vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
        end
      end,
    })

    vim.api.nvim_create_autocmd("LspDetach", { command = "setl foldexpr<" })
    vim.opt.foldlevel = 99

    require("mason").setup()
    require("mason-lspconfig").setup {
      automatic_enable = true,
      automatic_installation = true,
      ensure_installed = {
        "cssls",
        "css_variables",
        "lua_ls",
        "jsonls",
        "yamlls",
        "gopls",
      },
    }
  end,
}
