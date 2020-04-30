function lean_load_right_prompt_items
    for item in lean_{$lean_right_prompt_items}
        set -g $item (_$item)
    end
end

function _lean_status
    if string match -q --invert '0' $last_pipestatus
        set -l fishPipestatusWithSignal (__fish_pipestatus_with_signal $last_pipestatus)

        if test (count $last_pipestatus) -gt 1 || string match -qe 'SIG' $fishPipestatusWithSignal
            if test $last_status -eq 0
                set -g lean_status_color $lean_status_success_color
                echo -n {$lean_status_success_icon}' '
            else
                set -g lean_status_color $lean_status_failure_color
                echo -n {$lean_status_failure_icon}' '
            end
            string join '|' (string replace 'SIG' '' $fishPipestatusWithSignal)
        end
    end
end

function _lean_cmd_duration
    if test (math $CMD_DURATION/1000) -gt $lean_cmd_duration_threshold
        echo -n (math --scale=$lean_cmd_duration_decimals $CMD_DURATION/1000)'s'
    end
end

function _lean_context
    if set -q SSH_TTY
        set -g lean_context_color $lean_context_ssh_color
        echo -n $USER'@'(prompt_hostname)
    else if test $USER = 'root'
        set -g lean_context_color $lean_context_root_color
        echo -n $USER'@'(prompt_hostname)
    end
end

function _lean_jobs
    if jobs -q
        echo -n $lean_jobs_icon # Gear icon
    end
end

function _lean_time
    date +$lean_time_format
end