# RUN: %fish %s
_tide_parent_dirs

set _tide_jobs 0
_tide_decolor (_tide_item_jobs) # CHECK:

set -lx tide_jobs_icon 
set -lx tide_jobs_threshold 1
set _tide_jobs 1
_tide_decolor (_tide_item_jobs) # CHECK: 

set _tide_jobs 2
_tide_decolor (_tide_item_jobs) # CHECK:  2
