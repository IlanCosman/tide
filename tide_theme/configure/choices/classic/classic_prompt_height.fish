function classic_prompt_height
    _title 'Prompt Height'

    _option 1 'One line'
    set -e fake_tide_left_prompt_items[(contains -i 'newline' $fake_tide_left_prompt_items)]
    set fake_tide_left_prompt_frame_enabled false
    set fake_tide_right_prompt_frame_enabled false
    _display_prompt

    _option 2 'Two lines'
    set -g fake_tide_left_prompt_items $fake_tide_left_prompt_items 'newline'
    set fake_tide_left_prompt_frame_enabled true
    set fake_tide_right_prompt_frame_enabled true
    _display_prompt

    _display_restart_and_quit

    switch (_menu)
        case 1
            set -e fake_tide_left_prompt_items[(contains -i 'newline' $fake_tide_left_prompt_items)]
            set fake_tide_left_prompt_frame_enabled false
            set fake_tide_right_prompt_frame_enabled false
            _next_choice 'all/prompt_connection_andor_frame_color'
        case 2
            set -e fake_tide_left_prompt_items[(contains -i 'newline' $fake_tide_left_prompt_items)]
            set -g fake_tide_left_prompt_items $fake_tide_left_prompt_items 'newline'
            set fake_tide_left_prompt_frame_enabled true
            set fake_tide_right_prompt_frame_enabled true
            _next_choice 'classic/classic_prompt_connection'
        case r
            _begin
        case q
            _quit
    end
end