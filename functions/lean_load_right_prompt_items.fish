function lean_load_right_prompt_items
    for item in lean_{$lean_right_prompt_items}
        set -g $item (eval "_$item")
    end
end

function _lean_timer
    if test (math $CMD_DURATION/1000) -gt $lean_timer_duration
        set -l lean_timer_output (math --scale=$lean_timer_decimals $CMD_DURATION/1000)"s"
        echo -n $lean_timer_output
    end
end

function _lean_context
    if set -q SSH_TTY
        set -g lean_context_color $lean_context_ssh_color

        set -l lean_context_output $USER'@'(prompt_hostname)
        echo -n $lean_context_output
    else if test $USER = "root"
        set -g lean_context_color $lean_context_root_color

        set -l lean_context_output $USER'@'(prompt_hostname)
        echo -n $lean_context_output
    end
end