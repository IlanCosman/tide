# RUN: %fish %s
_tide_parent_dirs

set -e _tide_jobs
_tide_decolor (_tide_item_jobs) # CHECK:

set -lx tide_jobs_icon 
set -lx _tide_jobs
_tide_decolor (_tide_item_jobs) # CHECK: 
