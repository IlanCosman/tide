function show_time
    _tide_title 'Show current time?'

    _tide_option 1 No
    _tide_display_prompt

    set -a fake_tide_right_prompt_items time

    _tide_option 2 '24-hour format'
    _tide_display_prompt fake_tide_time_format '%T'

    _tide_option 3 '12-hour format'
    _tide_display_prompt fake_tide_time_format '%r'

    _tide_menu
    switch $_tide_selected_option
        case 1
            set -g fake_tide_time_format ''
            set -e fake_tide_right_prompt_items[-1]
        case 2
            set -g fake_tide_time_format '%T'
        case 3
            set -g fake_tide_time_format '%r'
    end
    switch $_tide_configure_style
        case lean
            _next_choice "$_tide_configure_style"/"$_tide_configure_style"_prompt_height
        case classic rainbow
            _next_choice "$_tide_configure_style"/"$_tide_configure_style"_prompt_separators
    end
end
