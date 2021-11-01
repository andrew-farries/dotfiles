function vz --description "open vim using fzf"
  set -l file (fzf --header='[open in vim]' --preview='bat --color always {}')

  if test -n "$file"
    vi "$file"
  end
end
