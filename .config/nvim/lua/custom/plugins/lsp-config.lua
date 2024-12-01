local on_attach = require("autocommands").on_attach

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/nvim-cmp",
    -- "saghen/blink.cmp",
    "b0o/schemastore.nvim",
  },
  config = function()
    -- local capabilities = require("blink.cmp").get_lsp_capabilities()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    local lspconfig = require "lspconfig"

    require("mason-lspconfig").setup {
      automatic_installation = true,
      ensure_installed = {
        "jsonls",
        "lua_ls",
        "taplo",
        "typos_lsp",
        "pyright",
        "yamlls",
      },
      handlers = {
        function(server_name)
          lspconfig[server_name].setup {
            capabilities = capabilities,
          }
        end,
        ["lua_ls"] = function(server_name)
          lspconfig[server_name].setup {
            capabilities = capabilities,
            settings = {
              Lua = {
                -- disable formatting as it is handled by null-ls
                -- format = false,
                diagnostics = {
                  globals = {
                    "vim",
                  },
                },
                hint = { enable = true },
              },
            },
          }
        end,
        ["jsonls"] = function(server_name)
          lspconfig[server_name].setup {
            capabilities = capabilities,
            settings = {
              json = {
                schemas = require("schemastore").json.schemas(),
                validate = { enable = true },
              },
            },
          }
        end,
        ["yamlls"] = function(server_name)
          lspconfig[server_name].setup {
            capabilities = capabilities,
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
        ["ts_ls"] = function(server_name)
          lspconfig[server_name].setup {
            capabilities = capabilities,
            settings = {
              javascript = {
                inlayHints = {
                  includeInlayEnumMemberValueHints = true,
                  includeInlayFunctionLikeReturnTypeHints = true,
                  includeInlayFunctionParameterTypeHints = true,
                  includeInlayParameterNameHints = "all",
                  includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                  includeInlayPropertyDeclarationTypeHints = true,
                  includeInlayVariableTypeHints = true,
                },
              },
              typescript = {
                inlayHints = {
                  includeInlayEnumMemberValueHints = true,
                  includeInlayFunctionLikeReturnTypeHints = true,
                  includeInlayFunctionParameterTypeHints = true,
                  includeInlayParameterNameHints = "all",
                  includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                  includeInlayPropertyDeclarationTypeHints = true,
                  includeInlayVariableTypeHints = true,
                },
              },
            },
          }
        end,
      },
    }

    require("lspconfig").gleam.setup {
      capabilities = capabilities,
      on_attach = on_attach,
    }
  end,
}
