function lean_prompt_connection
    _tide_title 'Prompt Connection'

    _tide_option 1 'Disconnected'
    _tide_display_prompt fake_tide_prompt_connection_icon ''

    _tide_option 2 'Dotted'
    _tide_display_prompt fake_tide_prompt_connection_icon '·'

    _tide_option 3 'Solid'
    _tide_display_prompt fake_tide_prompt_connection_icon '─'

    _tide_display_restart_and_tide_quit

    switch (_tide_menu)
        case 1
            set -g fake_tide_prompt_connection_icon ''
            _next_choice 'all/prompt_connection_andor_frame_color'
        case 2
            set -g fake_tide_prompt_connection_icon '·'
            _next_choice 'all/prompt_connection_andor_frame_color'
        case 3
            set -g fake_tide_prompt_connection_icon '─'
            _next_choice 'all/prompt_connection_andor_frame_color'
        case r
            _tide_begin
        case q
            _tide_quit
    end
end