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
