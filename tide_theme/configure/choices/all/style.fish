function style
    _title 'Style'

    _option 1 'Lean'
    _load_config "$_tide_dir/configure/configs/lean.fish"
    _display_prompt

    _option 2 'Pure'
    _load_config "$_tide_dir/configure/configs/pure.fish"
    _display_prompt

    _display_restart_and_quit

    switch (_menu 'Choice' 1/2/r/q)
        case 1
            _load_config "$_tide_dir/configure/configs/lean.fish"
            _next_choice 'lean/lean_show_time'
        case 2
            _load_config "$_tide_dir/configure/configs/pure.fish"
            _next_choice 'pure/pure_nonperm_content_location'
        case r
            _begin
        case q
            _quit
    end
end

function _load_config -a file
    for var in $fake_tide_var_list
        set -e $var
    end

    set -g fake_tide_var_list
    
    source $file
end

function _set -a var_name
    set -g $var_name $argv[2..-1]
    set -a fake_tide_var_list $var_name
end