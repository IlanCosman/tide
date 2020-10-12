function style
    _tide_title 'Prompt Style'

    _tide_option 1 'Lean'
    _load_config 'lean'
    _tide_display_prompt

    _tide_option 2 'Classic'
    _load_config 'classic'
    _tide_display_prompt

    _tide_option 3 'Rainbow'
    _load_config 'rainbow'
    _tide_display_prompt

    _tide_option 4 'Pure'
    _load_config 'pure'
    _tide_display_prompt

    _tide_display_restart_and_tide_quit

    switch (_tide_menu)
        case 1
            _load_config lean
            _next_choice 'lean/lean_show_time'
        case 2
            _load_config classic
            _next_choice 'classic/classic_prompt_color'
        case 3
            _load_config rainbow
            _next_choice 'rainbow/rainbow_show_time'
        case 4
            _load_config pure
            _next_choice 'pure/pure_nonperm_content_location'
        case r
            _tide_begin
        case q
            _tide_quit
    end
end

function _load_config -a name
    for var in $fake__tide_var_list
        set -e $var
    end
    set -g fake__tide_var_list

    for line in fake_(cat "$_tide_dir/configure/configs/$name.fish")
        set -a fake__tide_var_list (string split --max 1 ' ' $line)[1]
        eval set -g $line
    end
end