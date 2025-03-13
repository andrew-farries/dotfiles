function shell_level --description "Print the shell level"
  if test $SHLVL -gt 2
    echo -n (set_color cyan)'['(set_color blue)NESTED(set_color cyan)'] '
  end
end
