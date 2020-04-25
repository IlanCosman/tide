function lean_load_right_prompt_modules
    for module in lean_{$lean_right_prompt_modules}
        set -g $module (eval "_$module")
    end
end

function _lean_timer
    if test (math $CMD_DURATION/1000) -gt $lean_timer_duration
        set -l lean_timer_output (math --scale=$lean_timer_decimals $CMD_DURATION/1000)"s"
        echo -n $lean_timer_output
    end
end

function _lean_ssh
    if set -q SSH_TTY
        set -l lean_ssh_output $USER'@'(prompt_hostname)
        echo -n $lean_ssh_output
    end
end