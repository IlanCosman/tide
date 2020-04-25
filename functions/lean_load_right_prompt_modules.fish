function lean_load_right_prompt_modules
    set -g leanTimer (_lean_timer)
end

function _lean_timer
    if test (math $CMD_DURATION/1000) -gt $lean_timer_duration
        set -l leanTimerOutput (math --scale=$lean_timer_decimals $CMD_DURATION/1000)"s"
        echo -n $leanTimerOutput
    end
end