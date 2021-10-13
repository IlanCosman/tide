function _tide_item_cmd_duration
    test $CMD_DURATION -gt $tide_cmd_duration_threshold && time=(math --scale=0 "$CMD_DURATION/3600000" # Hours
        math --scale=0 "$CMD_DURATION/60000"%60 # Minutes
        math --scale=$tide_cmd_duration_decimals "$CMD_DURATION/1000"%60) if test $time[1] != 0
        _tide_print_item cmd_duration $tide_cmd_duration_icon' ' "$time[1]h $time[2]m $time[3]s"
    else if test $time[2] != 0
        _tide_print_item cmd_duration $tide_cmd_duration_icon' ' "$time[2]m $time[3]s"
    else
        _tide_print_item cmd_duration $tide_cmd_duration_icon' ' "$time[3]s"
    end
end
