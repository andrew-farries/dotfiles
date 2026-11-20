return {
  settings = {
    gopls = {
      gofumpt = true,
      experimentalPostfixCompletions = true,
      staticcheck = true,
      symbolScope = 'workspace',
      hints = {
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        assignVariableTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    },
  },
}
