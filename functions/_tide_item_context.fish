function _tide_item_context
    if set -q SSH_TTY
        set -fx tide_context_color $tide_context_color_ssh
    else if test "$EUID" = 0
        set -fx tide_context_color $tide_context_color_root
    else if test "$tide_context_always_display" = true
        set -fx tide_context_color $tide_context_color_default
    else
        return
    end

    string match -qr "^(?<h>(\.?[^\.]*){0,$tide_context_hostname_parts})" @$hostname
    _tide_print_item context $USER$h
end
