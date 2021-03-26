# RUN: %fish %s

function _status
    set -lx _tide_last_status $status
    set -lx _tide_last_pipestatus $pipestatus
    _tide_decolor (_tide_item_status)
end

set -lx tide_status_success_icon '✔'
set -lx tide_status_failure_icon '✘'

# Without prompt_char
set -lx tide_left_prompt_items

true
_status # CHECK: ✔

false
_status # CHECK: ✘ 1

true | false
_status # CHECK: ✘ 0|1

true | true
_status # CHECK: ✔

false | true
_status # CHECK: ✔ 1|0

false | false
_status # CHECK: ✘ 1|1

# With prompt_char
set -lx tide_left_prompt_items prompt_char

true
_status # CHECK:

false
_status # CHECK:

true | false
_status # CHECK: ✘ 0|1

true | true
_status # CHECK:

false | true
_status # CHECK: ✔ 1|0

false | false
_status # CHECK: ✘ 1|1

# Check that not command works
not true | false
_status # CHECK: ✔ 0|1

not false | true
_status # CHECK: ✘ 1|0
