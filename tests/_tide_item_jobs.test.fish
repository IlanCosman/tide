# RUN: %fish %s
_tide_parent_dirs

set -lx tide_jobs_icon 
set -lx tide_jobs_number_threshold 2

set -e _tide_jobs
_tide_decolor (_tide_item_jobs) # CHECK:

set -lx _tide_jobs 1
_tide_decolor (_tide_item_jobs) # CHECK: 

set -lx _tide_jobs 2
_tide_decolor (_tide_item_jobs) # CHECK:  2
