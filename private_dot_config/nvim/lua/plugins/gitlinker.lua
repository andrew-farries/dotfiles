require('gitlinker').setup({})

vim.keymap.set({ 'n', 'v' }, '<leader>gl', '<cmd>GitLink<cr>', { desc = 'Yank git link' })
vim.keymap.set({ 'n', 'v' }, '<leader>gL', '<cmd>GitLink!<cr>', { desc = 'Open git link' })
