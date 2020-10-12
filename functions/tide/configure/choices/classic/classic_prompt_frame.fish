function classic_prompt_frame
    _tide_title 'Prompt Frame'

    _tide_option 1 'No frame'
    set fake_tide_left_prompt_frame_enabled false
    set fake_tide_right_prompt_frame_enabled false
    set -a fake_tide_left_prompt_items prompt_char
    _tide_display_prompt
    set -e fake_tide_left_prompt_items[-1]

    _tide_option 2 'Left'
    set fake_tide_left_prompt_frame_enabled true
    set fake_tide_right_prompt_frame_enabled false
    _tide_display_prompt

    _tide_option 3 'Right'
    set fake_tide_left_prompt_frame_enabled false
    set fake_tide_right_prompt_frame_enabled true
    set -a fake_tide_left_prompt_items prompt_char
    _tide_display_prompt
    set -e fake_tide_left_prompt_items[-1]

    _tide_option 4 'Full'
    set fake_tide_left_prompt_frame_enabled true
    set fake_tide_right_prompt_frame_enabled true
    _tide_display_prompt

    _tide_display_restart_and_tide_quit

    switch (_tide_menu)
        case 1
            set fake_tide_left_prompt_frame_enabled false
            set fake_tide_right_prompt_frame_enabled false
            set -a fake_tide_left_prompt_items prompt_char
            _next_choice 'all/prompt_connection_andor_frame_color'
        case 2
            set fake_tide_left_prompt_frame_enabled true
            set fake_tide_right_prompt_frame_enabled false
            _next_choice 'all/prompt_connection_andor_frame_color'
        case 3
            set fake_tide_left_prompt_frame_enabled false
            set fake_tide_right_prompt_frame_enabled true
            set -a fake_tide_left_prompt_items prompt_char
            _next_choice 'all/prompt_connection_andor_frame_color'
        case 4
            set fake_tide_left_prompt_frame_enabled true
            set fake_tide_right_prompt_frame_enabled true
            _next_choice 'all/prompt_connection_andor_frame_color'
        case r
            _tide_begin
        case q
            _tide_quit
    end
end