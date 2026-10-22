function fish_user_key_bindings
  #
  # Use emacs keybindings when in insert mode
  # See the fish shell docs:
  # https://fishshell.com/docs/current/interactive.html 
  #

  fish_default_key_bindings -M insert
  fish_vi_key_bindings --no-erase insert

  fzf_key_bindings
end
