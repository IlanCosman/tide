function fake_prompt
    set_color $fake_tide_prompt_connection_color
    string repeat --no-newline --max $fake_columns $fake_tide_prompt_connection_icon
    printf '%b' '\r'

    _fake_tide_right_prompt
    _fake_tide_left_prompt
    set_color normal
end
