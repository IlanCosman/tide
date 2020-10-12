function classic_prompt_heads
    _tide_title 'Prompt Heads'

    _tide_option 1 'Sharp'
    set -g fake_tide_left_prompt_suffix ''
    set -g fake_tide_right_prompt_prefix ''
    _tide_display_prompt

    _tide_option 2 'Blurred'
    set -g fake_tide_left_prompt_suffix '▓▒░'
    set -g fake_tide_right_prompt_prefix '░▒▓'
    _tide_display_prompt

    _tide_option 3 'Slanted'
    set -g fake_tide_left_prompt_suffix ''
    set -g fake_tide_right_prompt_prefix ''
    _tide_display_prompt

    _tide_option 4 'Round'
    set -g fake_tide_left_prompt_suffix ''
    set -g fake_tide_right_prompt_prefix ''
    _tide_display_prompt

    _tide_display_restart_and_tide_quit

    switch (_tide_menu)
        case 1
            set -g fake_tide_left_prompt_suffix ''
            set -g fake_tide_right_prompt_prefix ''
            _next_choice 'classic/classic_prompt_tails'
        case 2
            set -g fake_tide_left_prompt_suffix '▓▒░'
            set -g fake_tide_right_prompt_prefix '░▒▓'
            _next_choice 'classic/classic_prompt_tails'
        case 3
            set -g fake_tide_left_prompt_suffix ''
            set -g fake_tide_right_prompt_prefix ''
            _next_choice 'classic/classic_prompt_tails'
        case 4
            set -g fake_tide_left_prompt_suffix ''
            set -g fake_tide_right_prompt_prefix ''
            _next_choice 'classic/classic_prompt_tails'
        case r
            _tide_begin
        case q
            _tide_quit
    end
end