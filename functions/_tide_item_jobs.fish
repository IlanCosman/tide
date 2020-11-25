function _tide_item_jobs
    if test $_tide_jobs_number -gt 0
        set_color $tide_jobs_color

        if test "$tide_jobs_verbose" = true
            printf '%s' $tide_jobs_icon' ' $_tide_jobs_number
        else
            printf '%s' $tide_jobs_icon
        end
    end
end