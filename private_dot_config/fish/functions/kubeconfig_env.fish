function kubeconfig_env --description "Print a message if KUBECONFIG is set"
  if set -q KUBECONFIG
    echo -n (set_color blue)\ue81d(set_color cyan)
    echo -n ' '
  end
end
