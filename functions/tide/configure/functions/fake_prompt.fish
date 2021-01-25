function fake_prompt
    set -l fish_term24bit $fake_tide_true_color
    set -l fish_term256 $fake_tide_true_color

    set_color $fake_tide_prompt_connection_color
    string repeat --no-newline --max $fake_columns $fake_tide_prompt_connection_icon
    printf '%b' '\r'

    _fake_tide_right_prompt
    _fake_tide_left_prompt
    set_color normal
end
