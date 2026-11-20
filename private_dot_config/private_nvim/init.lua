--
-- Set basic options
--
require('config.options')

--
-- Define non-plugin-related keymaps
--
require('config.keymaps')

--
-- Define non-plugin-related autocommands
--
require('config.autocommands')

--
-- Load and configure plugins
--
require('plugins')

--
-- Configure LSP
--
require('config.lsp')
