function _tide_item_context
    if set -q SSH_TTY
        set_color $tide_context_ssh_color
        printf '%s' $USER'@'$hostname
    else if test $USER = 'root'
        set_color $tide_context_root_color
        printf '%s' $USER'@'$hostname
    end
end