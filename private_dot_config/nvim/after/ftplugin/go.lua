--
-- An ftplugin file for Go to undo some of the effects of the default Go ftplugin
-- that ships with Neovim.
-- 

-- Unset `formatprg` so that `gq` doesn't try to format Go code with `gofmt`.
vim.bo.formatprg = ""
