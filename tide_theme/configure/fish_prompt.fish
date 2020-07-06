# Created by tide configure
function fish_prompt --description 'Write out the prompt'
    set -g _tide_last_pipestatus $pipestatus
    set -g _tide_last_status $status

    if test "$tide_print_newline_before_prompt" = 'true'
        printf '%b' '\n'
    end

    set_color $tide_prompt_connection_color
    string repeat --no-newline --max $COLUMNS $tide_prompt_connection_icon
    printf '%b' '\r'

    _tide_right_prompt
    _tide_left_prompt
end