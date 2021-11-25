# RUN: %fish %s

function _status
    set -lx _tide_status $status
    set -lx _tide_pipestatus $pipestatus
    _tide_decolor (_tide_item_status)
end

set -lx tide_status_icon ✔
set -lx tide_status_icon_failure ✘

# Without character
set -lx _tide_left_items

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

# With character
set -lx _tide_left_items character

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
