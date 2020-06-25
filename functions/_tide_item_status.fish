function _tide_item_status
    if string match -q --invert '0' $_tide_last_pipestatus
        set -l fishPipestatusWithSignal (__fish_pipestatus_with_signal $_tide_last_pipestatus)

        if test (count $_tide_last_pipestatus) -gt 1 || string match -qe 'SIG' $fishPipestatusWithSignal
            if test $_tide_last_status -eq 0
                set_color $tide_status_success_color
                printf '%s ' {$tide_status_success_icon}
            else
                set_color $tide_status_failure_color
                printf '%s ' {$tide_status_failure_icon}
            end
            string replace 'SIG' '' $fishPipestatusWithSignal | string join '|'
        end
    end
end