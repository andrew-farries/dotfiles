require('toggleterm').setup({
  open_mapping = [[<c-t>]],
  direction = 'float',
  shell = 'fish',
  float_opts = {
    border = 'curved',
    height = function() return math.max(vim.o.lines - 4, 2) end,
    width = function() return math.max(vim.o.columns - 4, 10) end,
  },
})
