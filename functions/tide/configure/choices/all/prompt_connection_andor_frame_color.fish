function prompt_connection_andor_frame_color
    if test "$_tide_16color" = true
        _next_choice all/prompt_spacing
        return 0
    end

    test -n "$fake_tide_prompt_connection_icon" && set promptConnectionExists
    test "$fake_tide_left_prompt_frame_enabled" = true -o "$fake_tide_right_prompt_frame_enabled" = true && set frameExists

    if set -q promptConnectionExists && set -q frameExists
        set title "Connection & Frame Color"
    else if set -q promptConnectionExists
        set title "Connection Color"
    else if set -q frameExists
        set title "Frame Color"
    else
        _next_choice all/prompt_spacing
        return 0
    end

    _tide_title $title

    _tide_option 1 Lightest
    _set_prompt_connection_and_frame_color 808080
    _tide_display_prompt

    _tide_option 2 Light
    _set_prompt_connection_and_frame_color 6C6C6C
    _tide_display_prompt

    _tide_option 3 Dark
    _set_prompt_connection_and_frame_color 585858
    _tide_display_prompt

    _tide_option 4 Darkest
    _set_prompt_connection_and_frame_color 444444
    _tide_display_prompt

    _tide_menu
    switch $_tide_selected_option
        case 1
            _set_prompt_connection_and_frame_color 808080
        case 2
            _set_prompt_connection_and_frame_color 6C6C6C
        case 3
            _set_prompt_connection_and_frame_color 585858
        case 4
            _set_prompt_connection_and_frame_color 444444
    end
    _next_choice all/prompt_spacing
end

function _set_prompt_connection_and_frame_color -a color
    set -g fake_tide_prompt_connection_color $color
    set -g fake_tide_left_prompt_frame_color $color
    set -g fake_tide_right_prompt_frame_color $color
end
