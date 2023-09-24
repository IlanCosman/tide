function prompt_connection
    _tide_title 'Prompt Connection'

    _tide_option 1 Disconnected
    set -g fake_tide_prompt_icon_connection ' '
    _tide_display_prompt

    _tide_option 2 Dotted
    set -g fake_tide_prompt_icon_connection '·'
    _tide_display_prompt

    _tide_option 3 Solid
    set -g fake_tide_prompt_icon_connection '─'
    _tide_display_prompt

    _tide_menu (status function)
    switch $_tide_selected_option
        case Disconnected
            set -g fake_tide_prompt_icon_connection ' '
        case Dotted
            set -g fake_tide_prompt_icon_connection '·'
        case Solid
            set -g fake_tide_prompt_icon_connection '─'
    end
    switch $_tide_configure_style
        case lean
            _next_choice all/prompt_connection_andor_frame_color
        case classic rainbow
            _next_choice powerline/powerline_right_prompt_frame
    end
end
