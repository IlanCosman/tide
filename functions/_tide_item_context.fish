function _tide_item_context
    if set -q SSH_TTY
        set_color $tide_context_ssh_color
        printf '%s' $USER'@'$hostname
    else if contains -- $USER root toor Administrator
        set_color $tide_context_root_color
        printf '%s' $USER'@'$hostname
    else if test "$tide_context_always_display" = true
        set_color $tide_context_default_color
        printf '%s' $USER'@'$hostname
    end
end
