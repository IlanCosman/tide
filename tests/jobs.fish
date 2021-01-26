# RUN: %fish %s

function _jobs -a number
    set -lx _tide_jobs_number $number
    _tide_decolor (_tide_item_jobs)
end

_jobs 0 # CHECK:

set -lx tide_jobs_icon ''

set -lx tide_jobs_verbose false
_jobs 2 # CHECK: 

set -lx tide_jobs_verbose true
_jobs 2 # CHECK:  2
