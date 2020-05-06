# Fishtape test
source "$__fish_config_dir/functions/lean_load_right_prompt_items.fish"

function _case
    set -g last_pipestatus $pipestatus
    set -g last_status $status
    _lean_status
end

@test 'true' (true;_case) -z
@test 'false' (false;_case) -z
@test 'true|false' (true|false;_case) = '✘ 0|1'
@test 'true|true' (true|true;_case) -z
@test 'false|true' (false|true;_case) = '✔ 1|0'
@test 'false|false' (false|false;_case) = '✘ 1|1'
