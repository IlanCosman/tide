function _tide_item_cmd_duration
    if test $CMD_DURATION -gt $tide_cmd_duration_threshold
        math --scale=$tide_cmd_duration_decimals "$CMD_DURATION/1000"%60 | read -l seconds
        math --scale=0 "$CMD_DURATION/60000"%60 | read -l minutes
        math --scale=0 "$CMD_DURATION/3600000" | read -l hours

        if test $hours != 0
            _tide_print_item cmd_duration $tide_cmd_duration_icon' ' $hours'h ' $minutes'm ' $seconds's'
        else if test $minutes != 0
            _tide_print_item cmd_duration $tide_cmd_duration_icon' ' $minutes'm ' $seconds's'
        else if test $seconds != 0
            _tide_print_item cmd_duration $tide_cmd_duration_icon' ' $seconds's'
        end
    end
end
