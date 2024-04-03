--
-- Basic, non-plugin specific keymaps
--

-- Disable space in normal mode
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true, desc = "Disable space" })

-- Use <c-c> to clear and close various things
vim.keymap.set("n", "<C-c>", function() 
  vim.cmd.nohls()
  vim.cmd.cclose()
end, { desc = "Clear and close" })

-- Traverse the quickfix list
vim.keymap.set("n", "]q", vim.cmd.cnext, { desc = "Next quickfix item" })
vim.keymap.set("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix item" })

-- Use the system clipboard for yanks
vim.keymap.set({ 'n', 'v' }, 'y', '"*y', { desc = "Yank to system clipboard" })

-- Toggle diagnostic virtual text
vim.keymap.set("n", "<leader>dt", function()
  local x = vim.diagnostic.config().virtual_text

  vim.diagnostic.config({ virtual_text = not x })
  vim.notify("Diagnostic virtual text " .. (x and "disabled" or "enabled"))
end, { desc = "Toggle diagnostic virtual text" })
