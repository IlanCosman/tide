@echo '-------------jobs-------------'

function _jobs -a number
    set -lx _tide_jobs_number $number
    _tide_decolor (_tide_item_jobs)
end

@test 'No Jobs' -z (_jobs 0)

set -lx tide_jobs_icon ''

set -lx tide_jobs_verbose false
@test 'Jobs' (_jobs 2) = ''

set -lx tide_jobs_verbose true
@test 'Jobs' (_jobs 2) = ' 2'