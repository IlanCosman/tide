function _tide_item_status
    if string match -q 0 $_tide_pipestatus && not contains character $_tide_left_items
        _tide_print_item status $tide_status_icon
        return
    end

    if contains "$_tide_pipestatus" $_tide_status_simple_failures
        contains character $_tide_left_items || tide_status_bg_color=$tide_status_bg_color_failure \
            tide_status_color=$tide_status_color_failure _tide_print_item status $tide_status_icon_failure' ' 1
    else
        fish_status_to_signal $_tide_pipestatus | string replace SIG '' | string join '|' | read -l out
        test $_tide_status = 0 && _tide_print_item status $tide_status_icon' ' $out ||
            tide_status_bg_color=$tide_status_bg_color_failure tide_status_color=$tide_status_color_failure \
                _tide_print_item status $tide_status_icon_failure' ' $out
    end
end
