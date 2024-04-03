--
-- Configration for LSP servers
--
return {
  gopls = {
    gofumpt = true,
    experimentalPostfixCompletions = true,
    staticcheck = true,
    symbolScope = "workspace",
    --
    -- Inlay hints will be supported in nvim 0.10.
    -- Turn them all on for now, but they don't show.
    -- After 0.10 you will probably want to have a toggle
    -- for these.
    --
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
}
