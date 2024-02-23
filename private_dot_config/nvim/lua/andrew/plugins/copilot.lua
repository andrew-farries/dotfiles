return {
  "zbirenbaum/copilot.lua",
  event = InsertEnter,
  config = function()
    require('copilot').setup({
      panel = {
        auto_refresh = true,
      },
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = "<c-e>",
          accept_word = false,
          accept_line = false,
          next = "<c-j>",
          prev = "<c-k>",
          dismiss = "<c-x>",
        },
      },
    })
  end
}
