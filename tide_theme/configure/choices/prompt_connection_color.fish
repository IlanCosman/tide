function prompt_connection_color
    _title 'Connection Color'

    _option 1 'Lightest'
    _display_prompt fake_tide_prompt_connection_color 808080

    _option 2 'Light'
    _display_prompt fake_tide_prompt_connection_color 6C6C6C

    _option 3 'Dark'
    _display_prompt fake_tide_prompt_connection_color 585858

    _option 4 'Darkest'
    _display_prompt fake_tide_prompt_connection_color 444444

    _display_restart_and_quit

    switch (_menu 'Choice' 1/2/3/4/r/q)
        case 1
            set -g fake_tide_prompt_connection_color 808080
            _next_choice 'prompt_spacing'
        case 2
            set -g fake_tide_prompt_connection_color 6C6C6C
            _next_choice 'prompt_spacing'
        case 3
            set -g fake_tide_prompt_connection_color 585858
            _next_choice 'prompt_spacing'
        case 4
            set -g fake_tide_prompt_connection_color 444444
            _next_choice 'prompt_spacing'
        case r
            _begin
        case q
            _quit
    end
end