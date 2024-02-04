# RUN: %fish %s
_tide_parent_dirs

function _character
    set -lx _tide_status $status
    set -lx _tide_pipestatus $pipestatus
    _tide_decolor (_tide_item_character)
end

set -lx tide_character_icon_failure ✘

true
_character # CHECK: ❯

false
_character # CHECK: ✘

true | false
_character # CHECK: ✘

true | true
_character # CHECK: ❯

false | true
_character # CHECK: ❯

false | false
_character # CHECK: ✘

# Check that not command works
not true | false
_character # CHECK: ❯

not false | true
_character # CHECK: ✘
