function lean_prompt_connection
    _tide_title 'Prompt Connection'

    _tide_option 1 'Disconnected'
    _tide_display_prompt fake_tide_prompt_connection_icon ''

    _tide_option 2 'Dotted'
    _tide_display_prompt fake_tide_prompt_connection_icon '·'

    _tide_option 3 'Solid'
    _tide_display_prompt fake_tide_prompt_connection_icon '─'

    _tide_menu
    switch $_tide_selected_option
        case 1
            set -g fake_tide_prompt_connection_icon ''
            _next_choice 'all/prompt_connection_andor_frame_color'
        case 2
            set -g fake_tide_prompt_connection_icon '·'
            _next_choice 'all/prompt_connection_andor_frame_color'
        case 3
            set -g fake_tide_prompt_connection_icon '─'
            _next_choice 'all/prompt_connection_andor_frame_color'
    end
end