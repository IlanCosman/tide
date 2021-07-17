# RUN: %fish %s

function _jobs -a jobs
    set -lx _tide_jobs_status $jobs
    _tide_decolor (_tide_item_jobs)
end

_jobs 1 # CHECK:

set -lx tide_jobs_icon ''
_jobs 0 # CHECK: 
