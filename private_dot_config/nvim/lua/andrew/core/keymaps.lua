--
-- Basic, non-plugin specific keymaps
--

-- Disable space in normal mode
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true, desc = "Disable space" })

-- Use <c-c> to clear and close various things
vim.keymap.set("n", "<C-c>", function() 
  vim.cmd.nohls()
  vim.cmd.cclose()
  vim.cmd.lclose()
end, { desc = "Clear and close" })

-- use j and k to navigate wrapped lines intuitively
vim.keymap.set("n", "j", "gj", { desc = "move down" })
vim.keymap.set("n", "k", "gk", { desc = "move up" })

-- Use the system clipboard for yanks
vim.keymap.set({ 'n', 'v' }, 'y', '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set({ 'n', 'v' }, 'Y', '"+y$', { desc = "Yank to system clipboard" })

-- Toggle diagnostic virtual text
vim.keymap.set("n", "<leader>td", function()
  local x = vim.diagnostic.config().virtual_text

  vim.diagnostic.config({ virtual_text = not x })
  vim.notify("Diagnostic virtual text " .. (x and "disabled" or "enabled"))
end, { desc = "Toggle diagnostic virtual text" })

-- Use <esc> to exit insert mode in the terminal
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit insert mode in terminal" })

-- Show file info and copy filepath to system clipboard
vim.keymap.set("n", "<C-g>", function()
  local filepath = vim.fn.expand("%")
  vim.fn.setreg("+", filepath)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-g>", true, false, true), "n", false)
end, { desc = "Show file info and copy path to clipboard" })
