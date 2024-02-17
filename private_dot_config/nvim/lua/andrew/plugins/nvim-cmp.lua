return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
--			"hrsh7th/cmp-path",
--			"L3MON4D3/LuaSnip",
--			"saadparwaiz1/cmp_luasnip",
--			"rafamadriz/friendly-snippets",
--			"onsails/lspkind.nvim",
--			"windwp/nvim-ts-autotag",
--			"windwp/nvim-autopairs",
  },
  config = function()
    local cmp = require("cmp")
    local cmp_buffer = require('cmp_buffer')
    local cmp_lsp = require("cmp_nvim_lsp")

    cmp.setup({
      preselect = cmp.PreselectMode.None,
      snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
          -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
          -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
          -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
          -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'buffer', 
          option = {
            get_bufnrs = function()
              return vim.api.nvim_list_bufs()
            end
          }
        },
        -- { name = 'vsnip' }, -- For vsnip users.
        -- { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
      }),
      sorting = {
        comparators = {
          function(...) return cmp_buffer:compare_locality(...) end,
          -- add comparators for other sources here too.
        }
      },
    })

    -- Set up lspconfig.
    local capabilities = cmp_lsp.default_capabilities()
    require('lspconfig').gopls.setup({
      capabilities = capabilities,
    })
  end
}
