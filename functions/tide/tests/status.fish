# RUN: %fish %s

function _status
    set -g _tide_last_pipestatus $pipestatus
    _tide_decolor (_tide_item_status)
end


set -lx tide_status_success_icon
set -lx tide_status_failure_icon

true | false
_status # CHECK: 0|1

false | true
_status # CHECK: 1|0

set -lx tide_status_success_icon '✔'
set -lx tide_status_failure_icon '✘'


set -lx tide_status_always_display false

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


set -lx tide_status_always_display true

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
