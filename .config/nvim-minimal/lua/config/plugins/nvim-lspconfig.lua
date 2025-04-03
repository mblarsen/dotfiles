return {
  "neovim/nvim-lspconfig",
  dependencies = {
    {
      "williamboman/mason.nvim",
      config = function()
        require("mason").setup()
      end,
    },
    "williamboman/mason-lspconfig.nvim",
    "b0o/schemastore.nvim",
  },
  config = function()
    local lspconfig = require "lspconfig"

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

    require("mason-lspconfig").setup {
      automatic_installation = true,
      ensure_installed = {},
      handlers = {
        function(server_name)
          lspconfig[server_name].setup {
            -- capabilities = capabilities,
          }
        end,
        ["cssls"] = function(server_name)
          lspconfig[server_name].setup {}
        end,
        ["ts_ls"] = function(server_name)
          lspconfig[server_name].setup {}
        end,
        ["lua_ls"] = function(server_name)
          lspconfig[server_name].setup {
            -- capabilities = capabilities,
            settings = {
              Lua = {
                format = true,
                diagnostics = {
                  globals = {
                    "vim",
                  },
                },
                hint = {
                  enable = true,
                },
              },
            },
          }
        end,
        ["jsonls"] = function(server_name)
          lspconfig[server_name].setup {
            -- capabilities = capabilities,
            settings = {
              json = {
                schemas = require("schemastore").json.schemas(),
                validate = {
                  enable = true,
                },
              },
            },
          }
        end,
        ["yamlls"] = function(server_name)
          lspconfig[server_name].setup {
            -- capabilities = capabilities,
            settings = {
              yaml = {
                schemaStore = {
                  -- You must disable built-in schemaStore support if you want to use
                  -- this plugin and its advanced options like `ignore`.
                  enable = false,
                  -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                  url = "",
                },
                schemas = require("schemastore").yaml.schemas(),
              },
            },
          }
        end,
      },
    }

    require("lspconfig").gleam.setup {
      -- capabilities = capabilities,
      on_attach = on_attach,
    }
  end,
}
