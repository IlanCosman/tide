function _lean_cmd_duration
    if test $CMD_DURATION -gt $lean_cmd_duration_threshold
        set -l seconds (math --scale=$lean_cmd_duration_decimals "$CMD_DURATION/1000" % 60)
        set -l minutes (math -s0 "$seconds/60" % 60)
        set -l hours (math -s0 "$minutes/60" % 60)

        for time in hours minutes seconds
            if test $$time -eq 0
                set -e $time
            end
        end

        set_color $lean_cmd_duration_color
        echo -n {$hours}'h' {$minutes}'m' {$seconds}'s'
    end
end