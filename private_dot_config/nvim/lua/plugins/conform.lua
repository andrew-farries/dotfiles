require('conform').setup({
  default_format_opts = {
    lsp_format = 'never',
  },
  formatters_by_ft = {
    go         = { lsp_format = 'prefer' },
    gomod      = { lsp_format = 'prefer' },
    javascript = { 'prettier' },
    typescript = { 'prettier' },
  },
  format_on_save = function(bufnr)
    return { timeout_ms = 500, undojoin = true }
  end,
})
