function _tide_item_status
    if string match --quiet --invert '0' $_tide_last_pipestatus # If there is a failure anywhere in the pipestatus
        if test "$_tide_last_pipestatus" = '1' # If simple failure
            if test "$tide_status_always_display" = 'true'
                set -g tide_status_bg_color $tide_status_failure_bg_color
                set_color $tide_status_failure_color
                printf '%s' $tide_status_failure_icon' ' '1'
            end
        else
            if test $_tide_last_pipestatus[-1] -eq 0
                set -g tide_status_bg_color $tide_status_success_bg_color
                set_color $tide_status_success_color
                printf '%s' $tide_status_success_icon' '
            else
                set -g tide_status_bg_color $tide_status_failure_bg_color
                set_color $tide_status_failure_color
                printf '%s' $tide_status_failure_icon' '
            end

            __fish_pipestatus_with_signal $_tide_last_pipestatus | string replace 'SIG' '' | string join '|'
        end
    else if test "$tide_status_always_display" = 'true'
        set -g tide_status_bg_color $tide_status_success_bg_color
        set_color $tide_status_success_color
        printf '%s' $tide_status_success_icon
    end
end