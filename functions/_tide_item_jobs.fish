function _tide_item_jobs
    if test $_tide_jobs -gt $tide_jobs_threshold
        _tide_print_item jobs $tide_jobs_icon' ' $_tide_jobs
    else if test $_tide_jobs -gt 0
        _tide_print_item jobs $tide_jobs_icon
    end
end
