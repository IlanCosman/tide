# RUN: %fish %s

function _rust
    _tide_decolor (_tide_item_rust)
end

set -l rustDir ~/rustTest
mkdir -p $rustDir
cd $rustDir

mock rustc --version "echo rustc 1.30.0-beta"
set -lx tide_rust_verbose_version true
set -lx tide_rust_icon 

touch blah.rs
_rust # CHECK:  1.30.0-beta
rm blah.rs

_rust # CHECK:

touch Cargo.toml
set -lx tide_rust_verbose_version false
_rust # CHECK:  1.30.0

rm -r $rustDir
