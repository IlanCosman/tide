function powerline_prompt_heads
    _tide_title 'Prompt Heads'

    _tide_option 1 Sharp
    set -g fake_tide_left_prompt_suffix 
    set -g fake_tide_right_prompt_prefix 
    _tide_display_prompt

    _tide_option 2 Slanted
    set -g fake_tide_left_prompt_suffix 
    set -g fake_tide_right_prompt_prefix 
    _tide_display_prompt

    _tide_option 3 Round
    set -g fake_tide_left_prompt_suffix 
    set -g fake_tide_right_prompt_prefix 
    _tide_display_prompt

    _tide_menu (status function)
    switch $_tide_selected_option
        case Sharp
            set -g fake_tide_left_prompt_suffix 
            set -g fake_tide_right_prompt_prefix 
        case Slanted
            set -g fake_tide_left_prompt_suffix 
            set -g fake_tide_right_prompt_prefix 
        case Round
            set -g fake_tide_left_prompt_suffix 
            set -g fake_tide_right_prompt_prefix 
    end
    _next_choice powerline/powerline_prompt_tails
end
