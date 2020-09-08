function _tide_item_jobs
    if jobs --quiet # Use --quiet because its faster and most people wont use verbose
        set_color $tide_jobs_color

        if test "$tide_jobs_verbose" = true
            printf '%s' $tide_jobs_icon ' '(jobs --pid | count) # --pid because it's faster than just jobs
        else
            printf '%s' $tide_jobs_icon
        end
    end
end