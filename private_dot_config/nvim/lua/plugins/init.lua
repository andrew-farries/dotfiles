--
-- Autocommand to:
-- * build telescope-fzf-native when the plugin is installed or updated
-- * update nvim-treesitter parsers when the plugin is updated
--
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind

    if name == 'telescope-fzf-native.nvim'
       and (kind == 'install' or kind == 'update') then
      vim.system({ 'make' }, { cwd = ev.data.path }):wait()
    end

    if name == 'nvim-treesitter' and kind == 'update' then
      if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
      require('nvim-treesitter').update()
    end
  end,
})

--
-- Install plugins
--
vim.pack.add({
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
  'https://github.com/nvim-telescope/telescope.nvim',
  'https://github.com/nvim-telescope/telescope-ui-select.nvim',
  'https://github.com/wellle/targets.vim',
  'https://github.com/andrew-farries/nvim-unception',
  'https://github.com/kylechui/nvim-surround',
  'https://github.com/j-hui/fidget.nvim',
  'https://github.com/folke/snacks.nvim',
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/nvim-lualine/lualine.nvim',
  'https://github.com/kyazdani42/blue-moon',
  'https://github.com/akinsho/toggleterm.nvim',
  'https://github.com/linrongbin16/gitlinker.nvim',
  'https://github.com/alexghergh/nvim-tmux-navigation',
  'https://github.com/FabijanZulj/blame.nvim',
  'https://github.com/RRethy/vim-illuminate',
  'https://github.com/zbirenbaum/copilot.lua',
  'https://github.com/nvim-tree/nvim-tree.lua',
  'https://github.com/stevearc/conform.nvim',
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/okuuva/auto-save.nvim',
})

--
-- Enable builtin packages
--
vim.cmd.packadd('nohlsearch')
vim.cmd.packadd('nvim.difftool')

--
-- Configure plugins
--
require('plugins.telescope')
require('plugins.fidget')
require('plugins.snacks')
require('plugins.blue-moon')
require('plugins.lualine')
require('plugins.toggleterm')
require('plugins.gitlinker')
require('plugins.nvim-tmux-navigation')
require('plugins.blame')
require('plugins.vim-illuminate')
require('plugins.copilot')
require('plugins.nvim-web-devicons')
require('plugins.nvim-tree')
require('plugins.conform')
require('plugins.nvim-treesitter')
require('plugins.auto-save')
