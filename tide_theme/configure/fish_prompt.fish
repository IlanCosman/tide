function fish_prompt --description 'Created by tide configure'
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

function fish_right_prompt
    printf '%s' $_tide_fish_right_prompt_display
end