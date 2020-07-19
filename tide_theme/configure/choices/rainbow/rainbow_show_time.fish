function rainbow_show_time
    _tide_title 'Show current time?'

    _tide_option 1 'No'
    _tide_display_prompt

    set -a fake_tide_right_prompt_items 'time'
    
    _tide_option 2 '24-hour format'
    _tide_display_prompt fake_tide_time_format '%T'

    _tide_option 3 '12-hour format'
    _tide_display_prompt fake_tide_time_format '%r'

    _tide_display_restart_and_tide_quit

    switch (_tide_menu)
        case 1
            set -g fake_tide_time_format ''
            set -e fake_tide_right_prompt_items[-1]
            _next_choice 'rainbow/rainbow_prompt_separators'
        case 2
            set -g fake_tide_time_format '%T'
            _next_choice 'rainbow/rainbow_prompt_separators'
        case 3
            set -g fake_tide_time_format '%r'
            _next_choice 'rainbow/rainbow_prompt_separators'
        case r
            _tide_begin
        case q
            _tide_quit
    end
end