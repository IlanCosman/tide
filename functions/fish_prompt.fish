# Created by lean configure
function fish_prompt --description 'Write out the prompt'
    set -g last_pipestatus $pipestatus
    set -g last_status $status

    if test "$lean_newline" = 'true'
        printf '%b' '\n'
    end

    set_color $lean_prompt_connection_color
    printf "%.s$lean_prompt_connection_icon" (seq $COLUMNS)
    set_color $fish_color_normal

    printf '%b' '\r'
    lean_right_prompt

    printf '%b' '\r'
    lean_left_prompt
end
