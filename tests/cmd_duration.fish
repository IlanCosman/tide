@mesg '---------cmd_duration---------'

function _cmd_duration -a duration threshold decimals
    set -lx CMD_DURATION $duration
    set -lx tide_cmd_duration_threshold $threshold
    set -lx tide_cmd_duration_decimals $decimals

    _tide_decolor (_tide_item_cmd_duration)
end

@test 'Less than threshold' (_cmd_duration 2000 3000 0) -z
@test 'Decimals' (_cmd_duration 4567 3000 3) = '4.567s'
@test 'Minutes' (_cmd_duration 456700 3000 0) = '7m 36s'
@test 'Hours' (_cmd_duration 4567000 3000 0) = '1h 16m 7s'