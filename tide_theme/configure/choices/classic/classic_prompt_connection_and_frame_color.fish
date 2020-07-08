function classic_prompt_connection_color
    _title 'Connection Color'

    _option 1 'Lightest'
    set -g fake_tide_prompt_connection_color 808080
    _display_prompt

    _option 2 'Light'
    set -g fake_tide_prompt_connection_color 6C6C6C
    _display_prompt

    _option 3 'Dark'
    set -g fake_tide_prompt_connection_color 585858
    _display_prompt

    _option 4 'Darkest'
    set -g fake_tide_prompt_connection_color 444444
    _display_prompt

    _display_restart_and_quit

    switch (_menu 'Choice' 1/2/3/4/r/q)
        case 1
            set -g fake_tide_prompt_connection_color 808080
            _next_choice 'all/prompt_spacing'
        case 2
            set -g fake_tide_prompt_connection_color 6C6C6C
            _next_choice 'all/prompt_spacing'
        case 3
            set -g fake_tide_prompt_connection_color 585858
            _next_choice 'all/prompt_spacing'
        case 4
            set -g fake_tide_prompt_connection_color 444444
            _next_choice 'all/prompt_spacing'
        case r
            _begin
        case q
            _quit
    end
end