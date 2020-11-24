function _tide_item_cmd_duration
    if test $_tide_cmd_duration -gt $tide_cmd_duration_threshold
        set -l seconds (math --scale=$tide_cmd_duration_decimals "$_tide_cmd_duration/1000" % 60)
        set -l minutes (math --scale=0 "$_tide_cmd_duration/60000" % 60)
        set -l hours (math --scale=0 "$_tide_cmd_duration/3600000")

        set_color $tide_cmd_duration_color

        printf '%s' $tide_cmd_duration_icon' '

        if test $hours -gt 0
            printf '%s' $hours'h ' $minutes'm ' $seconds's'
        else if test $minutes -gt 0
            printf '%s' $minutes'm ' $seconds's'
        else if test $seconds -gt 0
            printf '%s' $seconds's'
        end
    end
end