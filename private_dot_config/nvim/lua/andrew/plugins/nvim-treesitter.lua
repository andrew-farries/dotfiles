return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
          ensure_installed = {
            "bash",
            "go",
            "html",
            "javascript",
            "lua",
            "nix",
            "rust",
            "tsx",
            "typescript",
            "vim",
            "vimdoc",
          },
          sync_install = false,
          highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
          },
          indent = {
            enable = false
          },
        })
    end
 }
