return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  config = function()
    require('telescope').setup({
      defaults = {
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
          },
        },
        sorting_strategy = "ascending",
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        }
      }
    })
    require('telescope').load_extension('fzf')

    local builtin = require('telescope.builtin')

    vim.keymap.set('n', '<c-p>', builtin.find_files, { desc = 'Telescope Find Files' })
    vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, { desc = 'Telescope Current Buffer Fuzzy Find' })

    vim.keymap.set('n', '<leader>rg', builtin.live_grep, { desc = 'Telescope Live Grep' })
    vim.keymap.set('n', '<leader>gs', builtin.grep_string, { desc = 'Telescope Grep String' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope Help Tags' })
    vim.keymap.set('n', '<leader>ch', builtin.command_history, { desc = 'Telescope Command History' })
    vim.keymap.set('n', '<leader>sh', builtin.search_history, { desc = 'Telescope Search History' })
    vim.keymap.set('n', '<leader>km', builtin.keymaps, { desc = 'Telescope Keymaps' })

    vim.keymap.set('n', '<leader><space>', function()
      builtin.buffers({ sort_mru = true })
    end, { desc = 'Telescope Buffers' })
  end,
}
