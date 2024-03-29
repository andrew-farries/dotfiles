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
vim.api.nvim_create_autocmd({"FocusGained", "TermLeave"}, {
  command = "silent! !",
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

--
--- Toggle terminal when editing from within terminal
--  and open the file in a new split
--
vim.api.nvim_create_autocmd("User", {
  callback = function()
    -- Toggle the terminal off.
    require('toggleterm').toggle_all()
    -- open in a new split
    vim.cmd("vsplit")
  end,
  group = "AndrewAuGroup",
  pattern = "UnceptionEditRequestReceived",
  desc = "Toggle terminal when editing from within terminal",
})
