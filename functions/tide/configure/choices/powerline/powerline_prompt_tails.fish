function powerline_prompt_tails
    _tide_title 'Prompt Tails'

    _tide_option 1 Flat
    set -g fake_tide_left_prompt_prefix ''
    set -g fake_tide_right_prompt_suffix ''
    _tide_display_prompt

    _tide_option 2 Sharp
    set -g fake_tide_left_prompt_prefix 
    set -g fake_tide_right_prompt_suffix 
    _tide_display_prompt

    _tide_option 3 Slanted
    set -g fake_tide_left_prompt_prefix 
    set -g fake_tide_right_prompt_suffix 
    _tide_display_prompt

    _tide_option 4 Round
    set -g fake_tide_left_prompt_prefix 
    set -g fake_tide_right_prompt_suffix 
    _tide_display_prompt

    _tide_option 5 Fade
    set -g fake_tide_left_prompt_prefix ░▒▓
    set -g fake_tide_right_prompt_suffix ▓▒░
    _tide_display_prompt

    _tide_menu (status function)
    switch $_tide_selected_option
        case Flat
            set -g fake_tide_left_prompt_prefix ''
            set -g fake_tide_right_prompt_suffix ''
        case Sharp
            set -g fake_tide_left_prompt_prefix 
            set -g fake_tide_right_prompt_suffix 
        case Slanted
            set -g fake_tide_left_prompt_prefix 
            set -g fake_tide_right_prompt_suffix 
        case Round
            set -g fake_tide_left_prompt_prefix 
            set -g fake_tide_right_prompt_suffix 
        case Fade
            set -g fake_tide_left_prompt_prefix ░▒▓
            set -g fake_tide_right_prompt_suffix ▓▒░
    end
    _next_choice powerline/powerline_prompt_style
end
