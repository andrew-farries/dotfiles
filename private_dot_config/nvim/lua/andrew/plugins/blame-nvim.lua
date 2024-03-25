return {
  "FabijanZulj/blame.nvim",
  config = function()
    require("blame").setup({
      commit_detail_view = "vsplit",

      vim.keymap.set('n', '<leader>gb', function()
        vim.cmd('ToggleBlame')
      end, { desc = 'Git blame' })
    })
  end,
}
