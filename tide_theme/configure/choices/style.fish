function style
    _title 'Style'

    _option 1 'Lean'
    source "$_tide_dir/configure/configs/lean.fish"
    _display_prompt

    _option 2 'Pure'
    source "$_tide_dir/configure/configs/pure.fish"
    _display_prompt

    _display_restart_and_quit

    switch (_menu 'Choice' 1/2/3/r/q)
        case 1
            source "$_tide_dir/configure/configs/lean.fish"
            _next_choice 'show_time'
        case 2
            source "$_tide_dir/configure/configs/pure.fish"
            _next_choice 'finish'
        case r
            _begin
        case q
            _quit
    end
end