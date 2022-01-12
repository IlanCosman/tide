function _tide_item_status
    if string match -qv 0 $_tide_pipestatus # If there is a failure anywhere in the pipestatus
        if test "$_tide_pipestatus" = 1 # If simple failure
            contains character $_tide_left_items || tide_status_bg_color=$tide_status_bg_color_failure \
                tide_status_color=$tide_status_color_failure _tide_print_item status $tide_status_icon_failure' ' 1
        else
            fish_status_to_signal $_tide_pipestatus | string replace SIG '' | string join '|' | read -l out
            test $_tide_status = 0 && _tide_print_item status $tide_status_icon' ' $out ||
                tide_status_bg_color=$tide_status_bg_color_failure tide_status_color=$tide_status_color_failure \
                    _tide_print_item status $tide_status_icon_failure' ' $out
        end
    else if not contains character $_tide_left_items
        _tide_print_item status $tide_status_icon
    end
end
