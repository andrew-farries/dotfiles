local parsers = {
  'bash',
  'go',
  'html',
  'javascript',
  'json',
  'lua',
  'nix',
  'rust',
  'tsx',
  'typescript',
  'vim',
  'vimdoc',
  'cue',
}

local filetypes = {
  'bash', 'sh',
  'go',
  'html',
  'javascript',
  'json',
  'lua',
  'nix',
  'rust',
  'typescriptreact',
  'typescript',
  'vim',
  'help',
  'cue',
}

require('nvim-treesitter').install(parsers)

-- Map filetypes whose names don't match the parser name
vim.treesitter.language.register('bash', 'sh')
vim.treesitter.language.register('tsx', 'typescriptreact')
vim.treesitter.language.register('vimdoc', 'help')

-- Start treesitter when opening a file of the specified types
vim.api.nvim_create_autocmd('FileType', {
  pattern = filetypes,
  callback = function() vim.treesitter.start() end,
})
