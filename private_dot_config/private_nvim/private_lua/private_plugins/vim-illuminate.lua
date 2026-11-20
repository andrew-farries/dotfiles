local illuminate = require('illuminate')

illuminate.configure({
  under_cursor = false,
})

vim.keymap.set('n', ']r', function() illuminate.goto_next_reference(false) end, { desc = 'Next reference' })
vim.keymap.set('n', '[r', function() illuminate.goto_prev_reference(false) end, { desc = 'Previous reference' })
