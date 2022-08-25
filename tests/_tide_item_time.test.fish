# RUN: %fish %s

function _time -a format
    _tide_decolor (tide_time_format="$format" _tide_item_time)
end

# None
_time '' # CHECK:

# 24 Hour
_time %T # CHECK: {{\d\d:\d\d:\d\d}}

# 12 Hour
_time %r # CHECK: {{\d\d:\d\d:\d\d (A|P)M}}
