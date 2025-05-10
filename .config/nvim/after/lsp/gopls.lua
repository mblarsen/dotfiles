return {
  settings = {
    gopls = {
      semanticTokens = true,
      hints = {
        assignVariableTypes = true,
        compositeLiteralTypes = true,
        compositeLiteralFields = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    },
  },
}
