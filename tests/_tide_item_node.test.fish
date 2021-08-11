# RUN: %fish %s

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

rm -r $tmpdir
