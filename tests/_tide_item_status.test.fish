# RUN: %fish %s
_tide_parent_dirs

function _status
    set -lx _tide_status $status
    set -lx _tide_pipestatus $pipestatus
    _tide_decolor (_tide_item_status)
end

function _return_status
    return $argv
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

# With character and tide_status_simple_failures
set -lx tide_status_simple_failures 2 4

true
_status # CHECK:

false
_status # CHECK: ✘ 1

_return_status 2
_status # CHECK:

_return_status 4
_status # CHECK:

_return_status 4 | _return_status 1
_status # CHECK: ✘ 4|1

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
