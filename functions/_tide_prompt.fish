function _tide_prompt
    # Variables are exported as strings, convert _tide_last_pipestatus back into a list
    set -g _tide_last_pipestatus (string split ' ' $_tide_last_pipestatus)

    test "$tide_print_newline_before_prompt" = 'true' && printf '%b' '\n'

    if set -q SSH_TTY
      set_color $tide_context_ssh_color
    else if test $USER = 'root'
      set_color --bold red
    else
      set_color $tide_prompt_connection_color
    end
    test -n "$tide_prompt_connection_icon" || set -l tide_prompt_connection_icon ' '
    string repeat --no-newline --max $COLUMNS $tide_prompt_connection_icon
    printf '%b' '\r'

    _tide_right_prompt
    _tide_left_prompt
    set_color normal
end
