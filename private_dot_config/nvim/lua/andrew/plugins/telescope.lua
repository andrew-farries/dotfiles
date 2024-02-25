return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local builtin = require('telescope.builtin')

    vim.keymap.set('n', '<c-p>', builtin.find_files, {})
    vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, {})
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
    vim.keymap.set('n', '<leader><space>', builtin.buffers, {})
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
  end,
}
