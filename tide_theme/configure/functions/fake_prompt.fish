function fake_prompt
    set -g last_pipestatus $pipestatus
    set -g last_status $status

    if test "$fake_tide_newline" = 'true'
        printf '%b' '\n'
    end

    set_color $fake_tide_prompt_connection_color
    printf "%.s$fake_tide_prompt_connection_icon" (seq $fake_columns)
    set_color normal

    printf '%b' '\r'
    _fake_tide_right_prompt

    printf '%b' '\r'
    _fake_tide_left_prompt
end
