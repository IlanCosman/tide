function _lean_context
    if set -q SSH_TTY
        set_color $lean_context_ssh_color
        printf $USER'@'(prompt_hostname)' '
    else if test $USER = 'root'
        set_color $lean_context_root_color
        printf $USER'@'(prompt_hostname)' '
    end
end