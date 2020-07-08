function classic_prompt_heads
    _title 'Prompt Heads'

    _option 1 'Sharp'
    set -g fake_tide_left_prompt_suffix ''
    set -g fake_tide_right_prompt_prefix ''
    _display_prompt

    _option 2 'Blurred'
    set -g fake_tide_left_prompt_suffix '▓▒░'
    set -g fake_tide_right_prompt_prefix '░▒▓'
    _display_prompt

    _option 3 'Slanted'
    set -g fake_tide_left_prompt_suffix ''
    set -g fake_tide_right_prompt_prefix ''
    _display_prompt

    _option 4 'Round'
    set -g fake_tide_left_prompt_suffix ''
    set -g fake_tide_right_prompt_prefix ''
    _display_prompt

    _display_restart_and_quit

    switch (_menu 'Choice' 1/2/3/4/r/q)
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
            _begin
        case q
            _quit
    end
end