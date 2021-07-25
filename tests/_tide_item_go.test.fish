# RUN: %fish %s

function _go
    _tide_decolor (_tide_item_go)
end

set -l goDir (mktemp -d)
cd $goDir

mock go version "echo go version go1.16.5 linux/amd64"
set -lx tide_go_icon 

_go # CHECK:

touch go.mod
_go # CHECK:  1.16.5

rm -r $goDir
