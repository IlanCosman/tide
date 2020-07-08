function style
    _title 'Prompt Style'

    _option 1 'Lean'
    _load_config 'lean'
    _display_prompt

    _option 2 'Classic'
    _load_config 'classic'
    _display_prompt

    _option 3 'Rainbow'
    _load_config 'rainbow'
    _display_prompt

    _option 4 'Pure'
    _load_config 'pure'
    _display_prompt

    _display_restart_and_quit

    switch (_menu 'Choice' 1/2/3/4/r/q)
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
            _begin
        case q
            _quit
    end
end

function _load_config -a name
    for var in $fake_tide_var_list
        set -e $var
    end

    set -g fake_tide_var_list

    source "$_tide_dir/configure/configs/$name.fish"
end

function _set -a var_name
    set -g $var_name $argv[2..-1]
    set -a fake_tide_var_list $var_name
end