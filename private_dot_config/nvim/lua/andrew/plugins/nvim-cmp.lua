return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp-signature-help",
--	"onsails/lspkind.nvim",
--	"windwp/nvim-ts-autotag",
--	"windwp/nvim-autopairs",
  },
  config = function()
    local cmp = require("cmp")
    local cmp_buffer = require('cmp_buffer')
    local cmp_lsp = require("cmp_nvim_lsp")

    cmp.setup({
      preselect = cmp.PreselectMode.None,
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
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
        ['<C-c>'] = cmp.mapping.abort(),
        ['<C-e>'] = function(fallback) fallback() end,
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer', 
          option = {
            get_bufnrs = function()
              return vim.api.nvim_list_bufs()
            end
          }
        },
        { name = 'path' },
        { name = 'nvim_lsp_signature_help' },
      }),
      sorting = {
        comparators = {
          function(...) return cmp_buffer:compare_locality(...) end,
          -- add comparators for other sources here too.
        }
      },
    })

    -- Use buffer source for `/` and `?`
    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' }
      }
    })

    -- Use cmdline & path source for ':'
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' }
      }, {
        { name = 'cmdline' }
      })
    })

    -- Set up lspconfig.
    local capabilities = cmp_lsp.default_capabilities()
    require('lspconfig').gopls.setup({
      capabilities = capabilities,
    })
  end
}
