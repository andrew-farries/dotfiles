return {
  "bluz71/vim-nightfly-guicolors",
  lazy=false,
  priority=1000,
  config = function()
    -- use line window separators
    vim.g.nightflyWinSeparator = 2
    vim.cmd([[colorscheme nightfly]])
  end,
}

-- return {
  -- "kyazdani42/blue-moon",
  -- lazy=false,
  -- priority=1000,
  -- config = function()
    -- vim.cmd([[colorscheme blue-moon]])
  -- end,
-- }
