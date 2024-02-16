-- This is where basic, non plugin related keymaps will go

--
-- Movement between windows
--
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Focus window: left"})
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Focus window: down"})
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Focus window: up"})
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Focus window: right"})

--
-- Disable space in normal mode
--
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
