function prompt_connection_andor_frame_color
    if test "$_tide_16color" = true ||
            test "$fake_tide_left_prompt_frame_enabled" = false -a \
                "$fake_tide_right_prompt_frame_enabled" = false -a \
                "$fake_tide_prompt_icon_connection" = ' '
        _next_choice all/prompt_spacing
        return 0
    end

    _tide_title "Connection & Frame Color"

    _tide_option 1 Lightest
    _tide_display_prompt fake_tide_prompt_color_frame_and_connection 808080

    _tide_option 2 Light
    _tide_display_prompt fake_tide_prompt_color_frame_and_connection 6C6C6C

    _tide_option 3 Dark
    _tide_display_prompt fake_tide_prompt_color_frame_and_connection 585858

    _tide_option 4 Darkest
    _tide_display_prompt fake_tide_prompt_color_frame_and_connection 444444

    _tide_menu
    switch $_tide_selected_option
        case 1
            set -g fake_tide_prompt_color_frame_and_connection 808080
        case 2
            set -g fake_tide_prompt_color_frame_and_connection 6C6C6C
        case 3
            set -g fake_tide_prompt_color_frame_and_connection 585858
        case 4
            set -g fake_tide_prompt_color_frame_and_connection 444444
    end
    _next_choice all/prompt_spacing
end
