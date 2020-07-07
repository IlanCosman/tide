function fake_prompt
    set -g _tide_last_pipestatus $pipestatus
    set -g _tide_last_status $status

    set_color $fake_tide_prompt_connection_color
    string repeat --no-newline --max $fake_columns $fake_tide_prompt_connection_icon
    printf '%b' '\r'

    _fake_tide_right_prompt
    set_color normal
    _fake_tide_left_prompt
    set_color normal
end
