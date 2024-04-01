return {
  "RRethy/vim-illuminate",
  config = function()
    local illuminate = require("illuminate")

    illuminate.configure({
      under_cursor = false,
    })

    -- Define mappings to move the cursor to the next/previous reference
    -- false is used to disable wrapping
    vim.keymap.set('n', ']r', function() illuminate.goto_next_reference(false) end)
    vim.keymap.set('n', '[r', function() illuminate.goto_prev_reference(false) end)
  end,
}
