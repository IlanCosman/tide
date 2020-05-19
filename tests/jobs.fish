@mesg '-------------jobs-------------'

function _jobs
    tide_decolor (_tide_jobs)
end

@test 'No Jobs' (_jobs) -z
@test 'Jobs' (sleep 60 &; _jobs) = "$tide_jobs_icon "