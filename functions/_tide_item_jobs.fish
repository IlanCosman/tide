function _tide_item_jobs
    set -q _tide_jobs && if test $_tide_jobs -ge $tide_jobs_number_threshold
        _tide_print_item jobs $tide_jobs_icon' ' $_tide_jobs
    else
        _tide_print_item jobs $tide_jobs_icon
    end
end
