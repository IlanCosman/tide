function powerline_prompt_frame
    _tide_title 'Prompt Frame'

    _tide_option 1 'No frame'
    set fake_tide_left_prompt_frame_enabled false
    set fake_tide_right_prompt_frame_enabled false
    set -a fake_tide_left_prompt_items character
    _tide_display_prompt
    set -e fake_tide_left_prompt_items[-1]

    _tide_option 2 Left
    set fake_tide_left_prompt_frame_enabled true
    set fake_tide_right_prompt_frame_enabled false
    _tide_display_prompt

    _tide_option 3 Right
    set fake_tide_left_prompt_frame_enabled false
    set fake_tide_right_prompt_frame_enabled true
    set -a fake_tide_left_prompt_items character
    _tide_display_prompt
    set -e fake_tide_left_prompt_items[-1]

    _tide_option 4 Full
    set fake_tide_left_prompt_frame_enabled true
    set fake_tide_right_prompt_frame_enabled true
    _tide_display_prompt

    _tide_menu (status function)
    switch $_tide_selected_option
        case 'No frame'
            set fake_tide_left_prompt_frame_enabled false
            set fake_tide_right_prompt_frame_enabled false
            set -a fake_tide_left_prompt_items character
        case Left
            set fake_tide_left_prompt_frame_enabled true
            set fake_tide_right_prompt_frame_enabled false
        case Right
            set fake_tide_left_prompt_frame_enabled false
            set fake_tide_right_prompt_frame_enabled true
            set -a fake_tide_left_prompt_items character
        case Full
            set fake_tide_left_prompt_frame_enabled true
            set fake_tide_right_prompt_frame_enabled true
    end
    _next_choice all/prompt_connection_andor_frame_color
end
