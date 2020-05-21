@mesg '------------status------------'

function _status
    set -g last_pipestatus $pipestatus
    set -g last_status $status
    _tide_decolor (_tide_item_status)
end

@test 'true' (true; _status) -z
@test 'false' (false; _status) -z
@test 'true|false' (true|false; _status) = "$tide_status_failure_icon 0|1 "
@test 'true|true' (true|true; _status) -z
@test 'false|true' (false|true; _status) = "$tide_status_success_icon 1|0 "
@test 'false|false' (false|false; _status) = "$tide_status_failure_icon 1|1 "