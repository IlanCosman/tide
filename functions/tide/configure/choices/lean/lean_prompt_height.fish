function lean_prompt_height
    _tide_title 'Prompt Height'

    _tide_option 1 'One line'
    _tide_find_and_remove newline fake_tide_left_prompt_items
    set -g fake_tide_left_prompt_suffix ''
    _tide_display_prompt

    _tide_option 2 'Two lines'
    set -g fake_tide_left_prompt_items $fake_tide_left_prompt_items[1..-2] newline $fake_tide_left_prompt_items[-1]
    set -g fake_tide_left_prompt_suffix ' '
    _tide_display_prompt

    _tide_menu (status function)
    switch $_tide_selected_option
        case 'One line'
            _tide_find_and_remove newline fake_tide_left_prompt_items
            set fake_tide_left_prompt_suffix ''
            _next_choice all/prompt_connection_andor_frame_color
        case 'Two lines'
            _tide_find_and_remove newline fake_tide_left_prompt_items
            set -g fake_tide_left_prompt_items $fake_tide_left_prompt_items[1..-2] newline $fake_tide_left_prompt_items[-1]
            set -g fake_tide_left_prompt_suffix ' '
            _next_choice all/prompt_connection
    end
end
