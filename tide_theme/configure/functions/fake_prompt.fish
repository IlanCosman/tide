function fake_prompt
    set -g _tide_last_pipestatus $pipestatus
    set -g _tide_last_status $status

    set_color $fake_tide_prompt_connection_color
    printf "%.s$fake_tide_prompt_connection_icon" (seq $fake_columns)
    set_color normal

    printf '%b' '\r'
    _fake_tide_right_prompt

    printf '%b' '\r'
    _fake_tide_left_prompt
end
