# Fishtape test
source "$__fish_config_dir/functions/lean_right_prompt.fish"

function _jobs
    lean_decolor (_lean_jobs)
end

@test 'No Jobs' (_jobs) -z
@test 'Jobs' (sleep 60 &; _jobs) = "$lean_jobs_icon"