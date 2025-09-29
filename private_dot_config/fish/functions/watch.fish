function watch --wraps watch
  KUBECOLOR_FORCE_COLORS=truecolor command watch -t --color -n1 "fish -c '$argv'"
end
