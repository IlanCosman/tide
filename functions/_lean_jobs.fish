function _lean_jobs
    if jobs -q
        set_color $lean_jobs_color
        echo -n $lean_jobs_icon
    end
end