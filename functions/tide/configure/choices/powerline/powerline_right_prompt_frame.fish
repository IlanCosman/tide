function powerline_right_prompt_frame
    _tide_title 'Right Prompt Frame'

    _tide_option 1 No
    set fake_tide_right_prompt_frame_enabled false
    _tide_display_prompt

    _tide_option 2 Yes
    set fake_tide_right_prompt_frame_enabled true
    _tide_display_prompt

    _tide_menu (status function)
    switch $_tide_selected_option
        case No
            set fake_tide_right_prompt_frame_enabled false
        case Yes
            set fake_tide_right_prompt_frame_enabled true
    end
    _next_choice all/prompt_connection_andor_frame_color
end
