--
-- Highlight on yank
--
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.hl.on_yank({ timeout = 250 })
  end,
  desc = 'Highlight on yank',
})

--
-- Reload buffers if changed on disk
--
vim.api.nvim_create_autocmd({ 'FocusGained', 'TermLeave' }, {
  command = 'silent! checktime',
  desc = 'Check for external changes on focus',
})

--
-- When nvim-unception forwards an edit request from a child nvim, toggle the
-- floating terminal off and open the file in a vertical split.
--
vim.api.nvim_create_autocmd('User', {
  pattern = 'UnceptionEditRequestReceived',
  callback = function()
    require('toggleterm').toggle_all()
    vim.cmd('vsplit')
  end,
  desc = 'Open file from child nvim in a new split',
})
