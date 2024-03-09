--
-- Non-plugin specific autocommands
--

vim.api.nvim_create_augroup("AndrewAuGroup", { clear = true })

--
-- Auto-save: write the file on every change and when focus is lost
--
vim.api.nvim_create_autocmd({"InsertLeave", "TextChanged", "FocusLost"}, {
  command = "silent! update",
  group = "AndrewAuGroup",
  desc = "Auto-save: write the buffer on every change",
})

--
-- Reload the file on focus gained
--
vim.api.nvim_create_autocmd({"FocusGained"}, {
  command = "edit",
  group = "AndrewAuGroup",
  desc = "Reload the buffer on focus gained",
})

--
-- Highlight on yank
--
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank { timeout = 250 }
  end,
  group = "AndrewAuGroup",
  desc = "Highlight on yank",
})
