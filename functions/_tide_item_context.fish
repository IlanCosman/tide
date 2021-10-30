function _tide_item_context
    if set -q SSH_TTY
        tide_context_color=$tide_context_color_ssh _tide_print_item context $USER'@'$hostname
    else if contains -- $USER root toor Administrator
        tide_context_color=$tide_context_color_root _tide_print_item context $USER'@'$hostname
    else if test -f /run/.toolboxenv
        tide_context_color=$tide_context_color_root _tide_print_item context $USER'@'$hostname
    else if test "$tide_context_always_display" = true
        tide_context_color=$tide_context_color_default _tide_print_item context $USER'@'$hostname
    end
end
