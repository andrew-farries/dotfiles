return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    local builtin = require('telescope.builtin')

    vim.keymap.set('n', '<leader>de', vim.diagnostic.open_float)
    vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist)

    -- Use LspAttach autocommand to only map the following keys
    -- after the language server attaches to the current buffer
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)

        -- Find references
        vim.keymap.set('n', 'grr', function()
          builtin.lsp_references({
            include_declaration = false,
        })
        end, opts)
        --
        -- Find references ignoring test files
        vim.keymap.set('n', 'grR', function()
          builtin.lsp_references({
            include_declaration = false,
            file_ignore_patterns = { "%_test.go" },
        })
        end, opts)

        vim.keymap.set('n', 'go', function()
          builtin.lsp_document_symbols({
            symbol_width = 80,
            symbol_type_width = 10,
          })
        end, opts)

        vim.keymap.set('n', '<leader>s', function()
          builtin.lsp_dynamic_workspace_symbols({})
        end, opts)

        -- disabled as it conflicts with tmux navigation
        -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)

        vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<leader>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', 'gry', vim.lsp.buf.type_definition, opts)

        -- redundant when using conform
        -- vim.keymap.set('n', '<leader>f', function()
        --   vim.lsp.buf.format { async = true }
        -- end, opts)
      end,
    })
  end,
}
