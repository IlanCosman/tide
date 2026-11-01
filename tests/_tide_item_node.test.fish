# RUN: %fish %s
_tide_parent_dirs

function _node
    _tide_decolor (_tide_item_node)
end

set -l tmpdir (mktemp -d)
cd $tmpdir

mock node --version "echo v16.5.0"
set -lx tide_node_icon ⬢

_node # CHECK:

touch package.json
_node # CHECK: ⬢ 16.5.0

# No error when node isn't installed
functions --erase node
PATH= _node # CHECK:

command rm -r $tmpdir
