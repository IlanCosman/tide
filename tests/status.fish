@mesg '------------status------------'

function _status
    set -g _tide_last_pipestatus $pipestatus
    set -g _tide_last_status $status
    _tide_decolor (_tide_item_status)
end

set -l saved_tide_status_always_display_icon $tide_status_always_display_icon
set -g tide_status_always_display_icon false

@test 'true' (true; _status) -z
@test 'false' (false; _status) -z
@test 'true|false' (true|false; _status) = {$tide_status_failure_icon} '0|1'
@test 'true|true' (true|true; _status) -z
@test 'false|true' (false|true; _status) = {$tide_status_success_icon} '1|0'
@test 'false|false' (false|false; _status) = {$tide_status_failure_icon} '1|1'

set -g tide_status_always_display_icon true

@test 'true' (true; _status) = {$tide_status_success_icon}
@test 'false' (false; _status) = {$tide_status_failure_icon} '1'
@test 'true|false' (true|false; _status) = {$tide_status_failure_icon} '0|1'
@test 'true|true' (true|true; _status) = {$tide_status_success_icon}
@test 'false|true' (false|true; _status) = {$tide_status_success_icon} '1|0'
@test 'false|false' (false|false; _status) = {$tide_status_failure_icon} '1|1'