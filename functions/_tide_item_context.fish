function _tide_item_context
    if set -q SSH_TTY
        set -lx tide_context_color $tide_context_color_ssh
        test "$tide_context_hostname_parts" = 0 && _tide_print_item context $USER ||
            h=(string split . $hostname) _tide_print_item context $USER@(string join . $h[..$tide_context_hostname_parts])
    else if test "$EUID" = 0
        set -lx tide_context_color $tide_context_color_root
        test "$tide_context_hostname_parts" = 0 && _tide_print_item context $USER ||
            h=(string split . $hostname) _tide_print_item context $USER@(string join . $h[..$tide_context_hostname_parts])
    else if test "$tide_context_always_display" = true
        set -lx tide_context_color $tide_context_color_default
        test "$tide_context_hostname_parts" = 0 && _tide_print_item context $USER ||
            h=(string split . $hostname) _tide_print_item context $USER@(string join . $h[..$tide_context_hostname_parts])
    end
end
