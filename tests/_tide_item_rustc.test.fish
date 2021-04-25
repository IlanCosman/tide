# RUN: %fish %s

function _rustc
    _tide_decolor (_tide_item_rustc)
end

set -l rustcir ~/rustcest
mkdir -p $rustcir
cd $rustcir

mock rustc --version "echo rustc 1.30.0"
set -lx tide_rustcicon 

_rustc# CHECK:

touch Cargo.toml
_rustc# CHECK:  1.30.0

rm -r $rustcir
