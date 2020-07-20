function _tide_item_jobs
    if jobs --quiet
        set_color $tide_jobs_color
        printf '%s' $tide_jobs_icon
    end
end