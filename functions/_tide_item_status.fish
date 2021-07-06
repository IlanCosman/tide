function _tide_item_status
    # Variables are exported as strings, convert _tide_last_pipestatus back into a list
    set -l _tide_last_pipestatus (string split ' ' $_tide_last_pipestatus)

    if string match --quiet --invert 0 $_tide_last_pipestatus # If there is a failure anywhere in the pipestatus
        if test "$_tide_last_pipestatus" = 1 # If simple failure
            contains character $tide_left_prompt_items || tide_status_bg_color=$tide_status_bg_color_failure \
                tide_status_color=$tide_status_color_failure _tide_print_item status $tide_status_icon_failure' ' 1
        else if test $_tide_last_status = 0
            _tide_print_item status $tide_status_icon' ' \
                (fish_status_to_signal $_tide_last_pipestatus | string replace SIG '' | string join '|')
        else
            tide_status_bg_color=$tide_status_bg_color_failure tide_status_color=$tide_status_color_failure \
                _tide_print_item status $tide_status_icon_failure' ' \
                (fish_status_to_signal $_tide_last_pipestatus | string replace SIG '' | string join '|')
        end
    else if not contains character $tide_left_prompt_items
        _tide_print_item status $tide_status_icon
    end
end
