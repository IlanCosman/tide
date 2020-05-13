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