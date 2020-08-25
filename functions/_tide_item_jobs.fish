function _tide_item_jobs
    if jobs --quiet # Use jobs --quiet because its faster, and most people wont use verbose
        if test "$tide_jobs_verbose" = true
            set jobs_number (jobs --pid | count) # --pid because it's faste than just jobs
        end

        set_color $tide_jobs_color
        printf '%s' $tide_jobs_icon ' '{$jobs_number}
    end
end