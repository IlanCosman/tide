function pure_prompt_height
    _title 'Prompt Height'

    _option 1 'One line'
    set -e fake_tide_left_prompt_items[(contains -i 'newline' $fake_tide_left_prompt_items)]
    _display_prompt

    _option 2 'Two lines'
    set -g fake_tide_left_prompt_items $fake_tide_left_prompt_items[1..-2] 'newline' $fake_tide_left_prompt_items[-1]
    _display_prompt

    _display_restart_and_quit

    switch (_menu 'Choice' 1/2/r/q)
        case 1
            set -e fake_tide_left_prompt_items[(contains -i 'newline' $fake_tide_left_prompt_items)]
            _next_choice 'all/prompt_spacing'
        case 2
            set -e fake_tide_left_prompt_items[(contains -i 'newline' $fake_tide_left_prompt_items)]
            set -g fake_tide_left_prompt_items $fake_tide_left_prompt_items[1..-2] 'newline' $fake_tide_left_prompt_items[-1]
            _next_choice 'all/prompt_spacing'
        case r
            _begin
        case q
            _quit
    end
end