function _lean_jobs
    if jobs -q
        set_color $lean_jobs_color
        printf '%s ' $lean_jobs_icon
    end
end