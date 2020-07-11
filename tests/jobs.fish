@mesg '-------------jobs-------------'

function _jobs
    _tide_decolor (_tide_item_jobs)
end

@test 'No Jobs' (_jobs) -z

set -lx tide_jobs_icon ''
@test 'Jobs' (sleep 60 &; _jobs) = ''