return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      open_mapping = [[<c-t>]],
      direction = 'float',
      shell = 'fish',
      float_opts = {
        border = 'curved',
        height = function(term)
          return math.max(vim.o.lines - 4, 2)
        end,
        width = function(term)
          return math.max(vim.o.columns - 4, 10)
        end,
      }
  })
  end,
}
