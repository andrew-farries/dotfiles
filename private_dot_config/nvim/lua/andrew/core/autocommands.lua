--
-- Non-plugin specific autocommands
--

vim.api.nvim_create_augroup("AndrewAuGroup", { clear = true })

--
-- Auto-save: write the file on every change and when focus is lost
-- The `silent!` is used to suppress the "No write since last change" message
-- The exclamation mark is used to suppress the error message if the buffer
-- is not modifiable.
-- nested = true is used to allow the autocmd to to trigger other autocmds
--
vim.api.nvim_create_autocmd({"InsertLeave", "TextChanged", "FocusLost"}, {
  callback = function(tbl)
    -- vim.notify('Auto-saving' .. vim.inspect(tbl))
    vim.cmd("silent! update")
  end,
  nested = true,
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
-- Toggle terminal when editing from within terminal
-- and open the file in a new split
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

--
-- Ensure that any git commit message and rebase buffers are wiped on close.
-- This prevents them hanging around in the buffer list.
--
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    vim.bo.bufhidden = "wipe"
  end,
  pattern = "gitcommit,gitrebase",
  group = "AndrewAuGroup",
  desc = "Set buffer options for git buffers",
})
