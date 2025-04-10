# RUN: %fish %s
_tide_parent_dirs

function _rustc
    _tide_decolor (_tide_item_rustc)
end

set -l rustcDir (mktemp -d)
cd $rustcDir

mock rustup \* "echo \"stable-x86_64-unknown-linux-gnu (default)\"; echo \"rustc 1.86.0 (05f9846f8 2025-03-31)\""

set -lx tide_rustc_icon 

_rustc # CHECK:

touch Cargo.toml
_rustc # CHECK:  1.86.0

command rm -r $rustcDir
