# RUN: %fish %s
_tide_parent_dirs

function _cmd_duration_precise -a duration threshold decimals
    set -lx CMD_DURATION $duration
    set -lx tide_cmd_duration_threshold $threshold
    set -lx tide_cmd_duration_decimals $decimals

    _tide_decolor (_tide_item_cmd_duration)
end

# threshold
_cmd_duration 2000 3000 0 # Check:

# formatting
_cmd_duration 0567 0000 3 # CHECK: 567ms
_cmd_duration 4567 3000 2 # CHECK: 4.57s
_cmd_duration 4567 3000 3 # CHECK: 4.567s
_cmd_duration 456789 3000 3 # CHECK: 7m 36s
_cmd_duration 4567000 3000 3 # CHECK: 1h 16m
