function fish_prompt --description 'Write out the prompt'
    echo -n -s (set_color green) (kubeconfig_env) (set_color cyan) '[' (set_color $fish_color_cwd)(basename (dirs))(set_color cyan) '] ' (git_info) (set_color normal) '> '
end
