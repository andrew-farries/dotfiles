return {
  "stevearc/conform.nvim",
  opts = {
    -- Don't do any formatting by default, opt-in per file type
    default_format_opts = {
      lsp_format = "never",
    },

    -- Enable formatting for specific file types
    formatters_by_ft = {
      go    = { lsp_format = "prefer" },
      gomod = { lsp_format = "prefer" },
    },

    -- Automatically format on save
    format_on_save = {
      timeout_ms = 500,
    },
  }
}
