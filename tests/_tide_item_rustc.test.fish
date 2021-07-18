# RUN: %fish %s

function _rustc
    _tide_decolor (_tide_item_rustc)
end

set -l rustcDir (mktemp -d)
cd $rustcDir

mock rustc --version "echo rustc 1.30.0"
set -lx tide_rustc_icon 

_rustc # CHECK:

touch Cargo.toml
_rustc # CHECK:  1.30.0

rm -r $rustcDir
