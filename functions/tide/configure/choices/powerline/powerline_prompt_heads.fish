function powerline_prompt_heads
    _tide_title 'Prompt Heads'

    _tide_option 1 Sharp
    set -g fake_tide_left_prompt_suffix ''
    set -g fake_tide_right_prompt_prefix ''
    _tide_display_prompt

    _tide_option 2 Blurred
    set -g fake_tide_left_prompt_suffix '▓▒░'
    set -g fake_tide_right_prompt_prefix '░▒▓'
    _tide_display_prompt

    _tide_option 3 Slanted
    set -g fake_tide_left_prompt_suffix ''
    set -g fake_tide_right_prompt_prefix ''
    _tide_display_prompt

    _tide_option 4 Round
    set -g fake_tide_left_prompt_suffix ''
    set -g fake_tide_right_prompt_prefix ''
    _tide_display_prompt

    _tide_menu
    switch $_tide_selected_option
        case 1
            set -g fake_tide_left_prompt_suffix ''
            set -g fake_tide_right_prompt_prefix ''
        case 2
            set -g fake_tide_left_prompt_suffix '▓▒░'
            set -g fake_tide_right_prompt_prefix '░▒▓'
        case 3
            set -g fake_tide_left_prompt_suffix ''
            set -g fake_tide_right_prompt_prefix ''
        case 4
            set -g fake_tide_left_prompt_suffix ''
            set -g fake_tide_right_prompt_prefix ''
    end
    _next_choice powerline/powerline_prompt_tails
end
