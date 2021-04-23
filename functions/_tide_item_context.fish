function _tide_item_context
    if set -q SSH_TTY
        set -g tide_context_color $tide_context_ssh_color
        _tide_print_item context $USER'@'$hostname
    else if contains -- $USER root toor Administrator
        set -g tide_context_color $tide_context_root_color
        _tide_print_item context $USER'@'$hostname
    else if test "$tide_context_always_display" = true
        set -g tide_context_color $tide_context_default_color
        _tide_print_item context $USER'@'$hostname
    end
end
