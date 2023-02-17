# RUN: %fish %s
_tide_parent_dirs

function _time -a format
    LC_TIME=en_US.UTF-8 _tide_decolor (tide_time_format="$format" _tide_item_time)
end

# None
_time '' # CHECK:

# 24 Hour
_time %T # CHECK: {{\d\d:\d\d:\d\d}}

# 12 Hour
_time %r # CHECK: {{\d\d:\d\d:\d\d (A|P)M}}
