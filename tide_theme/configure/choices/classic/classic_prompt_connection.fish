function classic_prompt_connection
    _title 'Prompt Connection'

    _option 1 'Disconnected'
    _display_prompt fake_tide_prompt_connection_icon ''

    _option 2 'Dotted'
    _display_prompt fake_tide_prompt_connection_icon '·'

    _option 3 'Solid'
    _display_prompt fake_tide_prompt_connection_icon '─'

    _display_restart_and_quit

    switch (_menu)
        case 1
            set -g fake_tide_prompt_connection_icon ''
            _next_choice 'classic/classic_prompt_frame'
        case 2
            set -g fake_tide_prompt_connection_icon '·'
            _next_choice 'classic/classic_prompt_frame'
        case 3
            set -g fake_tide_prompt_connection_icon '─'
            _next_choice 'classic/classic_prompt_frame'
        case r
            _begin
        case q
            _quit
    end
end