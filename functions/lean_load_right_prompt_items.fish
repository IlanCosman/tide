function lean_load_right_prompt_items
    for item in lean_{$lean_right_prompt_items}
        set -g $item (eval "_$item")
    end
end

function _lean_timer
    if test (math $CMD_DURATION/1000) -gt $lean_timer_duration
        echo -n (math --scale=$lean_timer_decimals $CMD_DURATION/1000)"s"
    end
end

function _lean_context
    if set -q SSH_TTY
        set -g lean_context_color $lean_context_ssh_color
        echo -n $USER'@'(prompt_hostname)
    else if test $USER = "root"
        set -g lean_context_color $lean_context_root_color
        echo -n $USER'@'(prompt_hostname)
    end
end

function _lean_jobs
    if jobs -q
        echo -n $lean_jobs_icon # Gear icon
    end
end