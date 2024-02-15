--
-- Non-plugin specific autocommands
--

vim.api.nvim_create_augroup("AndrewAuGroup", { clear = true })

--
-- Auto-save: write the file on every change
--
-- vim.api.nvim_create_autocmd({"TextChanged", "TextChangedI"}, {
  -- command = "silent! update",
  -- group = "AndrewAuGroup",
  -- desc = "Auto-save: write the buffer on every change",
-- })

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
