@mesg '-------------jobs-------------'

function _jobs
    lean_decolor (_lean_jobs)
end

@test 'No Jobs' (_jobs) -z
@test 'Jobs' (sleep 60 &; _jobs) = "$lean_jobs_icon "