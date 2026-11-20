require('auto-save').setup({
  trigger_events = {
    immediate_save = { 'BufLeave', 'FocusLost', 'QuitPre', 'VimSuspend' },
    defer_save = { 'InsertLeave', 'TextChanged' },
    cancel_deferred_save = { 'InsertEnter' },
  },
  debounce_delay = 50,
})
