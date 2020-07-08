function classic_prompt_tails
    _title 'Prompt Tails'

    _option 1 'Flat'
    set -g fake_tide_left_prompt_prefix ''
    set -g fake_tide_right_prompt_suffix ''
    _display_prompt

    _option 2 'Blurred'
    set -g fake_tide_left_prompt_prefix '░▒▓'
    set -g fake_tide_right_prompt_suffix '▓▒░'
    _display_prompt

    _option 3 'Sharp'
    set -g fake_tide_left_prompt_prefix ''
    set -g fake_tide_right_prompt_suffix ''
    _display_prompt

    _option 4 'Slanted'
    set -g fake_tide_left_prompt_prefix ''
    set -g fake_tide_right_prompt_suffix ''
    _display_prompt

    _option 5 'Round'
    set -g fake_tide_left_prompt_prefix ''
    set -g fake_tide_right_prompt_suffix ''
    _display_prompt

    _display_restart_and_quit

    switch (_menu 'Choice' 1/2/3/4/5/r/q)
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
            _begin
        case q
            _quit
    end
end