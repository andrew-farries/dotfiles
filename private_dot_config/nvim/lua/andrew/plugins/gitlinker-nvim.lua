return {
  "linrongbin16/gitlinker.nvim",
  cmd = "GitLink",
  opts = {},
  keys = {
    { "<leader>gl", "<cmd>GitLink<cr>", mode = { "n", "v" }, desc = "Yank git link" },
    { "<leader>gL", "<cmd>GitLink!<cr>", mode = { "n", "v" }, desc = "Open git link" },
  },
}
