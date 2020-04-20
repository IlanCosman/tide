function fish_prompt --description 'Write out the prompt'
    set -l last_status $status
    echo
    if test (math $CMD_DURATION/1000) -gt $lean_timer_duration
        for i in (seq (math $COLUMNS-(string length (echo -n " "(math --scale=$lean_timer_decimals $CMD_DURATION/1000)"s"))-1))
            set_color $lean_prompt_connection_color
            echo -n $lean_prompt_connection
            set_color $fish_color_normal
        end
        set_color $lean_timer_color
        echo -n " "(math --scale=$lean_timer_decimals $CMD_DURATION/1000)"s"
        set_color $fish_color_normal
    else
        for i in (seq (math $COLUMNS-1))
            set_color $lean_prompt_connection_color
            echo -n $lean_prompt_connection
            set_color $fish_color_normal
        end
    end
    echo -e "\r"(lean_pwd)(lean_git_prompt)" "
    # Prompt character
    if test $last_status -eq 0
        set_color $lean_green
    else
        set_color $fish_color_error
    end
    echo -n "❯ "
    set_color $fish_color_normal
end