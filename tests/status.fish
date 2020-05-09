# Fishtape test
@mesg '------------status------------'

source "$__fish_config_dir/functions/lean_right_prompt.fish"

function _status
    set -g last_pipestatus $pipestatus
    set -g last_status $status
    lean_decolor (_lean_status)
end

@test 'true' (true; _status) -z
@test 'false' (false; _status) -z
@test 'true|false' (true|false; _status) = "$lean_status_failure_icon 0|1"
@test 'true|true' (true|true; _status) -z
@test 'false|true' (false|true; _status) = "$lean_status_success_icon 1|0"
@test 'false|false' (false|false; _status) = "$lean_status_failure_icon 1|1"