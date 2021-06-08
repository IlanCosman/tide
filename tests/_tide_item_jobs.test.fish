# RUN: %fish %s

function _jobs -a jobs
    set -lx _tide_jobs $jobs
    _tide_decolor (_tide_item_jobs)
end

_jobs # CHECK:

set -lx tide_jobs_icon ''
_jobs blah # CHECK: 
