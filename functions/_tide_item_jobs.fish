function _tide_item_jobs
    if test $_tide_jobs_number != 0
        if test "$tide_jobs_verbose" = true
            _tide_print_item jobs $_tide_jobs_number
        else
            _tide_print_item jobs
        end
    end
end
