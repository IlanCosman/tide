function lean_show_time
    _title 'Show current time?'

    _option 1 'No'
    _display_prompt

    set -a fake_tide_right_prompt_items 'time'
    
    _option 2 '24-hour format'
    _display_prompt fake_tide_time_format '%T'

    _option 3 '12-hour format'
    _display_prompt fake_tide_time_format '%r'

    _display_restart_and_quit

    switch (_menu 'Choice' 1/2/3/r/q)
        case 1
            set -g fake_tide_time_format ''
            set -e fake_tide_right_prompt_items[-1]
            _next_choice 'lean/lean_prompt_height'
        case 2
            set -g fake_tide_time_format '%T'
            _next_choice 'lean/lean_prompt_height'
        case 3
            set -g fake_tide_time_format '%r'
            _next_choice 'lean/lean_prompt_height'
        case r
            _begin
        case q
            _quit
    end
end