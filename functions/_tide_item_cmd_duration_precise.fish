function _tide_item_cmd_duration_precise
    test $CMD_DURATION -lt $tide_cmd_duration_threshold
    and return 0

    set d $CMD_DURATION
    if test $d -ge 3600000
        set out (math -s0 $d / 3600000)'h '(math -s0 $d / 60000 % 60)'m'
    else if test $d -ge 60000
        set out (math -s0 $d / 60000 % 60)'m '(math -s0 $d / 1000 % 60)'s'
    else if test $d -ge 1000
        set out (math -s$tide_cmd_duration_decimals $d / 1000 % 60)'s'
    else
        set out (math -s0 $d % 1000)'ms'
    end

    _tide_print_item cmd_duration $tide_cmd_duration_icon' ' "$out"
end
