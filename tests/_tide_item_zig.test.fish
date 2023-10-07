# RUN: %fish %s
_tide_parent_dirs

function _zig
    _tide_decolor (_tide_item_zig)
end

set -l zigDir (mktemp -d)
cd $zigDir

mock zig version "echo 0.11.0"
set -lx tide_zig_icon 

_zig # CHECK:

touch build.zig
_zig # CHECK:  0.11.0

mock zig version "echo 0.12.0-dev.789+e6590fea1"
_zig # CHECK:  0.12.0-dev

command rm -r $zigDir
