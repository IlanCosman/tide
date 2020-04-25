function lean_load_right_prompt_modules
    set -g leanTimer (_lean_timer)
    set -g leanSSH (_lean_ssh)
end

function _lean_timer
    if test (math $CMD_DURATION/1000) -gt $lean_timer_duration
        set -l leanTimerOutput (math --scale=$lean_timer_decimals $CMD_DURATION/1000)"s"
        echo -n $leanTimerOutput
    end
end

function _lean_ssh
    if set -q SSH_TTY
        set -l leanSSHOutput $USER'@'(prompt_hostname)
        echo -n $leanSSHOutput
    end
end