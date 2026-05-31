require('blame').setup({
  commit_detail_view = 'vsplit',
})

vim.keymap.set('n', '<leader>gb', '<cmd>BlameToggle<cr>', { desc = 'Git blame' })
