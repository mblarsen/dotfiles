local on_attach = require("autocommands").on_attach

return {
  "neovim/nvim-lspconfig",
  event = "BufReadPre",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/nvim-cmp",
    "b0o/schemastore.nvim",
  },
  config = function(_, opts)
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    require("mason").setup {
      ensure_installed = {
        -- nvim-lint and the eslint-lsp kind of does the same thing
        -- will try to use nvim-lint for a while and see how goes
        -- "eslint",
        "eslint_d",
        "black",
        "typos-lsp",
        "prettier",
        "pylint",
        "type",
        "stylelua",
      },
      ui = {
        width = 0.95,
        height = 0.8,
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "󰁔",
          package_uninstalled = "✗",
        },
      },
    }

    require("mason-lspconfig").setup {
      ensure_installed = {
        -- "eslint",
        "jsonls",
        "lua_ls",
        "rust_analyzer",
        "taplo",
        "terraformls",
        "tsserver",
        "typos_lsp",
        "yamlls",
      },
      handlers = {
        function(server_name)
          require("lspconfig")[server_name].setup {
            capabilities = capabilities,
          }
        end,
        ["lua_ls"] = function(server_name)
          require("lspconfig")[server_name].setup {
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
          require("lspconfig")[server_name].setup {
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
          require("lspconfig")[server_name].setup {
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
        ["tsserver"] = function(server_name)
          require("lspconfig")[server_name].setup {
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
