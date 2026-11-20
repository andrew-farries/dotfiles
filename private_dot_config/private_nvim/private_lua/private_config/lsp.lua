local builtin = require('telescope.builtin')

--
-- Buffer-local mappings and features on LSP attach
--
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local opts = { buffer = args.buf }

    -- Override built-in grr to use telescope
    vim.keymap.set('n', 'grr', function()
      builtin.lsp_references({ include_declaration = false })
    end, opts)

    -- Override built-in gO to use telescope
    vim.keymap.set('n', 'gO', function()
      builtin.lsp_document_symbols({ symbol_width = 80, symbol_type_width = 10 })
    end, opts)

    -- Define `grs` for workspace symbols
    vim.keymap.set('n', 'grs', builtin.lsp_dynamic_workspace_symbols, opts)

    -- Enable native LSP completion; trigger on every typed character via the
    -- InsertCharPre autocommand. Do not trigger when the cursor is in a
    -- comment.
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = false })

      vim.api.nvim_create_autocmd('InsertCharPre', {
        buffer = args.buf,
        callback = function()
          vim.schedule(function()
            local row, col = unpack(vim.api.nvim_win_get_cursor(0))
            local captures = vim.treesitter.get_captures_at_pos(args.buf, row - 1, math.max(col - 1, 0))
            for _, c in ipairs(captures) do
              if c.capture == 'comment' then return end
            end
            vim.lsp.completion.get()
          end)
        end,
      })
    end
  end,
})

--
-- Completion menu behaviour
--
vim.opt.completeopt = { 'menuone', 'noinsert', 'popup', 'fuzzy' }

--
-- Enable LSP clients
--
vim.lsp.enable('gopls')
