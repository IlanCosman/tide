# RUN: %fish %s

function _rust
    _tide_decolor (_tide_item_rust)
end

set -l rustDir ~/rustTest
mkdir -p $rustDir
cd $rustDir

mock rustc --version "echo rustc 1.30.0"
set -lx tide_rust_icon 

_rust # CHECK:

touch Cargo.toml
_rust # CHECK:  1.30.0

rm -r $rustDir
