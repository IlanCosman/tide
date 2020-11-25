function _tide_prompt
    test "$tide_print_newline_before_prompt" = 'true' && printf '%b' '\n'

    set_color $tide_prompt_connection_color
    test -n "$tide_prompt_connection_icon" || set -l tide_prompt_connection_icon ' '
    string repeat --no-newline --max $COLUMNS $tide_prompt_connection_icon
    printf '%b' '\r'

    _tide_right_prompt
    _tide_left_prompt
end