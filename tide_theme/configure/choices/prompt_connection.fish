function prompt_connection
    _title 'Prompt Connection'

    _option 1 'Disconnected'
    _display_prompt fake_tide_prompt_connection_icon ' '

    _option 2 'Dotted'
    _display_prompt fake_tide_prompt_connection_icon '·'

    _option 3 'Solid'
    _display_prompt fake_tide_prompt_connection_icon '─'

    _display_restart_and_quit

    switch (_menu 'Choice' 1/2/3/r/q)
        case 1
            set -g fake_tide_prompt_connection_icon ' '
            _next_choice 'prompt_spacing'
        case 2
            set -g fake_tide_prompt_connection_icon '·'
            _next_choice 'prompt_connection_color'
        case 3
            set -g fake_tide_prompt_connection_icon '─'
            _next_choice 'prompt_connection_color'
        case r
            _begin
        case q
            _quit
    end
end