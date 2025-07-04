function kubeconfig_env --description "Print a message if KUBECONFIG is set"
  if set -q KUBECONFIG
    echo -n (set_color cyan)'['(set_color blue)\ue81d(set_color normal)' '(set_color 4FB3D9)(kubectl config current-context)(set_color cyan)'] '
  end
end
