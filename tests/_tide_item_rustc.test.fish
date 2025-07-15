# RUN: %fish %s
_tide_parent_dirs

_tide_item_rustc

function _rustc
    _tide_decolor (_tide_item_rustc)
end

set rustcDir (mktemp -d)
function cleanup -p $fish_pid
    command rm -r $rustcDir
end

cd $rustcDir

mock rustup \* "echo \"stable-x86_64-unknown-linux-gnu (default)\"; echo \"rustc 1.86.0 (05f9846f8 2025-03-31)\""

set -lx tide_rustc_icon 

_rustc # CHECK:

touch Cargo.toml
_rustc # CHECK:  1.86.0

mock rustc \* "echo 'rustc 1.85.1 (4eb161250 2025-03-15)'"

touch Cargo.toml
_rustc # CHECK:  1.85.1
