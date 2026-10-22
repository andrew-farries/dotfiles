require('kulala').setup({
  ui = {
    win_opts = {
      wo = { foldmethod = "manual" },
    },
  },
  global_keymaps = true,
  -- Disable the default keymaps for previous/next tab as they conflict with
  -- nvim-tmux-navigation keymaps
  kulala_keymaps = {
    ["Previous tab"] = false,
    ["Next tab"] = false,
  },
  global_keymaps_prefix = "<leader>R",
  kulala_keymaps_prefix = "",
  default_env = "dev",
})
