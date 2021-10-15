function powerline_prompt_tails
    _tide_title 'Prompt Tails'

    _tide_option 1 Flat
    set -g fake_tide_left_prompt_prefix ''
    set -g fake_tide_right_prompt_suffix ''
    _tide_display_prompt

    _tide_option 2 Blurred
    set -g fake_tide_left_prompt_prefix '░▒▓'
    set -g fake_tide_right_prompt_suffix '▓▒░'
    _tide_display_prompt

    _tide_option 3 Sharp
    set -g fake_tide_left_prompt_prefix 
    set -g fake_tide_right_prompt_suffix 
    _tide_display_prompt

    _tide_option 4 Slanted
    set -g fake_tide_left_prompt_prefix ''
    set -g fake_tide_right_prompt_suffix ''
    _tide_display_prompt

    _tide_option 5 Round
    set -g fake_tide_left_prompt_prefix ''
    set -g fake_tide_right_prompt_suffix ''
    _tide_display_prompt

    _tide_menu
    switch $_tide_selected_option
        case 1
            set -g fake_tide_left_prompt_prefix ''
            set -g fake_tide_right_prompt_suffix ''
        case 2
            set -g fake_tide_left_prompt_prefix '░▒▓'
            set -g fake_tide_right_prompt_suffix '▓▒░'
        case 3
            set -g fake_tide_left_prompt_prefix 
            set -g fake_tide_right_prompt_suffix 
        case 4
            set -g fake_tide_left_prompt_prefix ''
            set -g fake_tide_right_prompt_suffix ''
        case 5
            set -g fake_tide_left_prompt_prefix ''
            set -g fake_tide_right_prompt_suffix ''
    end
    _next_choice powerline/powerline_prompt_height
end
