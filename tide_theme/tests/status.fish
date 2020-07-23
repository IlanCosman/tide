@mesg '------------status------------'

function _status
    set -g _tide_last_pipestatus $pipestatus
    set -g _tide_last_status $status
    _tide_decolor (_tide_item_status)
end

@mesg 'icons empty'
set -lx tide_status_success_icon
set -lx tide_status_failure_icon

@test 'true|false' (true|false; _status) = '0|1'
@test 'false|true' (false|true; _status) = '1|0'

set -lx tide_status_success_icon '✔'
set -lx tide_status_failure_icon '✘'

@mesg 'always_display: false'
set -lx tide_status_always_display false

@test 'true' (true; _status) -z
@test 'false' (false; _status) -z
@test 'true|false' (true|false; _status) = '✘ 0|1'
@test 'true|true' (true|true; _status) -z
@test 'false|true' (false|true; _status) = '✔ 1|0'
@test 'false|false' (false|false; _status) = '✘ 1|1'

@mesg 'always_display: true'
set -lx tide_status_always_display true

@test 'true' (true; _status) = '✔'
@test 'false' (false; _status) = '✘ 1'
@test 'true|false' (true|false; _status) = '✘ 0|1'
@test 'true|true' (true|true; _status) = '✔'
@test 'false|true' (false|true; _status) = '✔ 1|0'
@test 'false|false' (false|false; _status) = '✘ 1|1'