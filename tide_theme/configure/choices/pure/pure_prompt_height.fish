function pure_prompt_height
    _tide_title 'Prompt Height'

    _tide_option 1 'One line'
    set -e fake_tide_left_prompt_items[(contains --index 'newline' $fake_tide_left_prompt_items)]
    _tide_display_prompt

    _tide_option 2 'Two lines'
    set -g fake_tide_left_prompt_items $fake_tide_left_prompt_items[1..-2] 'newline' $fake_tide_left_prompt_items[-1]
    _tide_display_prompt

    _tide_display_restart_and_tide_quit

    switch (_tide_menu)
        case 1
            set -e fake_tide_left_prompt_items[(contains --index 'newline' $fake_tide_left_prompt_items)]
            _next_choice 'all/prompt_connection_andor_frame_color'
        case 2
            set -e fake_tide_left_prompt_items[(contains --index 'newline' $fake_tide_left_prompt_items)]
            set -g fake_tide_left_prompt_items $fake_tide_left_prompt_items[1..-2] 'newline' $fake_tide_left_prompt_items[-1]
            _next_choice 'all/prompt_connection_andor_frame_color'
        case r
            _tide_begin
        case q
            _tide_quit
    end
end