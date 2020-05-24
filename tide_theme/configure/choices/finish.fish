function finish
    set_color red
    _title 'Overwrite tide config and fish_prompt?'
    set_color normal

    _option y 'Yes'
    printf '%b' '\n\n'

    _option n 'No'
    printf '%b' '\n\n'

    switch (_menu 'Choice' y/n)
        case y
            _set_tide_defaults

            if test -n "$fake_tide_time_format"
                set -a tide_right_prompt_items 'time'
            end

            set -l vars tide_{ \
                newline, \
                left_prompt_items, \
                prompt_connection_color, prompt_connection_icon, \
                time_format \
            }

            for var in $vars
                set -l fakeVar "fake_$var"
                set -U $var $$fakeVar
            end
        case n
    end

    _quit
end
