# RUN: %fish %s
_tide_parent_dirs

function _bun
    _tide_decolor (_tide_item_bun)
end

set -l tmpdir (mktemp -d)
cd $tmpdir

mock bun --version "echo 1.0.24"
set -lx tide_bun_icon 󰳓

_bun # CHECK:

touch bun.lockb
_bun # CHECK: 󰳓 1.0.24

command rm -r $tmpdir
