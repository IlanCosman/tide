function rainbow_prompt_frame
    _title 'Prompt Frame'

    _option 1 'No frame'
    set fake_tide_left_prompt_frame_enabled false
    set fake_tide_right_prompt_frame_enabled false
    set -a fake_tide_left_prompt_items prompt_char
    _display_prompt
    set -e fake_tide_left_prompt_items[-1]

    _option 2 'Left'
    set fake_tide_left_prompt_frame_enabled true
    set fake_tide_right_prompt_frame_enabled false
    _display_prompt

    _option 3 'Right'
    set fake_tide_left_prompt_frame_enabled false
    set fake_tide_right_prompt_frame_enabled true
    set -a fake_tide_left_prompt_items prompt_char
    _display_prompt
    set -e fake_tide_left_prompt_items[-1]

    _option 4 'Full'
    set fake_tide_left_prompt_frame_enabled true
    set fake_tide_right_prompt_frame_enabled true
    _display_prompt

    _display_restart_and_quit

    switch (_menu)
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
            _begin
        case q
            _quit
    end
end