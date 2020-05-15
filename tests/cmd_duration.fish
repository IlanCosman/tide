@mesg '---------cmd_duration---------'

function _cmd_duration -a duration threshold decimals
    set -g CMD_DURATION $duration
    set -g lean_cmd_duration_threshold $threshold
    set -g lean_cmd_duration_decimals $decimals

    lean_decolor (_lean_cmd_duration)
end

@test 'Less than threshold' (_cmd_duration 2000 3000 0) -z
@test 'Decimals' (_cmd_duration 4567 3000 3) = '4.567s '
@test 'Minutes' (_cmd_duration 456700 3000 0) = '7m 36s '
@test 'Hours' (_cmd_duration 4567000 3000 0) = '1h 16m 7s '