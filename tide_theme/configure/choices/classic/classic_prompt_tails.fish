function classic_prompt_tails
    _tide_title 'Prompt Tails'

    _tide_option 1 'Flat'
    set -g fake_tide_left_prompt_prefix ''
    set -g fake_tide_right_prompt_suffix ''
    _tide_display_prompt

    _tide_option 2 'Blurred'
    set -g fake_tide_left_prompt_prefix '░▒▓'
    set -g fake_tide_right_prompt_suffix '▓▒░'
    _tide_display_prompt

    _tide_option 3 'Sharp'
    set -g fake_tide_left_prompt_prefix ''
    set -g fake_tide_right_prompt_suffix ''
    _tide_display_prompt

    _tide_option 4 'Slanted'
    set -g fake_tide_left_prompt_prefix ''
    set -g fake_tide_right_prompt_suffix ''
    _tide_display_prompt

    _tide_option 5 'Round'
    set -g fake_tide_left_prompt_prefix ''
    set -g fake_tide_right_prompt_suffix ''
    _tide_display_prompt

    _tide_display_restart_and_tide_quit

    switch (_tide_menu)
        case 1
            set -g fake_tide_left_prompt_prefix ''
            set -g fake_tide_right_prompt_suffix ''
            _next_choice 'classic/classic_prompt_height'
        case 2
            set -g fake_tide_left_prompt_prefix '░▒▓'
            set -g fake_tide_right_prompt_suffix '▓▒░'
            _next_choice 'classic/classic_prompt_height'
        case 3
            set -g fake_tide_left_prompt_prefix ''
            set -g fake_tide_right_prompt_suffix ''
            _next_choice 'classic/classic_prompt_height'
        case 4
            set -g fake_tide_left_prompt_prefix ''
            set -g fake_tide_right_prompt_suffix ''
            _next_choice 'classic/classic_prompt_height'
        case 5
            set -g fake_tide_left_prompt_prefix ''
            set -g fake_tide_right_prompt_suffix ''
            _next_choice 'classic/classic_prompt_height'
        case r
            _tide_begin
        case q
            _tide_quit
    end
end