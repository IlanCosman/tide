function lean_right_prompt
    echo -n ' '

    for item in lean_{$lean_right_prompt_items}
        set -l itemOutput (_$item)

        if test -n "$itemOutput"
            echo -n $itemOutput' '
        end

        set_color normal
    end
end

function _lean_status
    if string match -q --invert '0' $last_pipestatus
        set -l fishPipestatusWithSignal (__fish_pipestatus_with_signal $last_pipestatus)

        if test (count $last_pipestatus) -gt 1 || string match -qe 'SIG' $fishPipestatusWithSignal
            if test $last_status -eq 0
                set_color $lean_status_success_color
                echo -n {$lean_status_success_icon}' '
            else
                set_color $lean_status_failure_color
                echo -n {$lean_status_failure_icon}' '
            end
            string join '|' (string replace 'SIG' '' $fishPipestatusWithSignal)
        end
    end
end

function _lean_cmd_duration
    set -l seconds (math --scale=$lean_cmd_duration_decimals $CMD_DURATION/1000)

    if test $seconds -gt $lean_cmd_duration_threshold
        set -l secondsMod (math $seconds % 60)

        set -l minutes (math -s0 $seconds/60)
        set -l minutesMod (math $minutes % 60)

        set -l hours (math -s0 $minutes/60)

        for time in hours minutesMod secondsMod
            if test $$time -eq 0
                set -e $time
            end
        end

        set_color $lean_cmd_duration
        echo -n {$hours}'h' {$minutesMod}'m' {$gsecondsMod}'s'
    end
end

function _lean_context
    if set -q SSH_TTY
        set_color $lean_context_ssh_color
        echo -n $USER'@'(prompt_hostname)
    else if test $USER = 'root'
        set_color $lean_context_root_color
        echo -n $USER'@'(prompt_hostname)
    end
end

function _lean_jobs
    if jobs -q
        set_color $lean_jobs_color
        echo -n $lean_jobs_icon
    end
end

function _lean_time
    set_color $lean_time_color
    date +$lean_time_format
end