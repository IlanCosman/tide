function _tide_item_guix
    if test -n "$GUIX_ENVIRONMENT"
        _tide_print_item guix $tide_guix_icon'' "[GUIX ENV]"
    end
end
