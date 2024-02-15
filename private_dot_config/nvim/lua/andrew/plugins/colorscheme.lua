--
-- catppuccin has integrations with many different plugins
-- Remember to enable support for them as each plugin is installed.
--
return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    vim.cmd([[colorscheme catppuccin-frappe]])
  end
}
