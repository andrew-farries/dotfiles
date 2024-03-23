--
-- catppuccin has integrations with many different plugins
-- Remember to enable support for them as each plugin is installed.
--
-- return {
  -- "catppuccin/nvim",
  -- name = "catppuccin",
  -- priority = 1000,
  -- config = function()
    -- vim.cmd([[colorscheme catppuccin-mocha]])
  -- end
-- }

return {
  "kyazdani42/blue-moon",
  priority = 1000,
  config = function()
    vim.cmd([[colorscheme blue-moon]])
  end
}
