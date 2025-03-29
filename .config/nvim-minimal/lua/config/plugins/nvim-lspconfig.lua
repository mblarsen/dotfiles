return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "williamboman/mason.nvim", config = function ()
      require ("mason").setup()
    end },
    "williamboman/mason-lspconfig.nvim",
    "b0o/schemastore.nvim",
  },
  config = function()
    local lspconfig = require "lspconfig"

    require("mason-lspconfig").setup {
      automatic_installation = true,
      ensure_installed = { },
      handlers = {
        function(server_name)
          lspconfig[server_name].setup {
            -- capabilities = capabilities,
          }
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
    }  end
}

