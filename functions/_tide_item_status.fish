function _tide_item_status
    if string match -q --invert '0' $_tide_last_pipestatus # If there is a failure somewhere in the pipestatus
        if test $_tide_last_status -eq 0
            set_color $tide_status_success_color
            printf '%s' {$tide_status_success_icon}' '
        else
            set_color $tide_status_failure_color
            printf '%s' {$tide_status_failure_icon}' '
        end

        __fish_pipestatus_with_signal $_tide_last_pipestatus | string replace -a 'SIG' '' | string join '|'
    else if test "$tide_status_always_display_icon" = 'true'
        set_color $tide_status_success_color
        printf '%s' $tide_status_success_icon
    end
end