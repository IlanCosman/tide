function _tide_item_status
    if string match -q --invert '0' $last_pipestatus
        set -l fishPipestatusWithSignal (__fish_pipestatus_with_signal $last_pipestatus)

        if test (count $last_pipestatus) -gt 1 || string match -qe 'SIG' $fishPipestatusWithSignal
            if test $last_status -eq 0
                set_color $tide_status_success_color
                printf '%s ' {$tide_status_success_icon}
            else
                set_color $tide_status_failure_color
                printf '%s ' {$tide_status_failure_icon}
            end
            printf '%s ' (string replace 'SIG' '' $fishPipestatusWithSignal | string join '|')
        end
    end
end