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

# must remove from PATH rustc to test fallback to rustup
# as:
# 1. with no mock for rustc we see system/rustup rustc
# 2. with rustc mocked we can't test fallback
# obviously this runs the risk of blowing up the test if rustc is is usr/bin or
# similar. Needs sandboxing with docker or nix or similar for local testing to
# work smoothly.
set -l rust_binary rustc
while type -P $rust_binary &>/dev/null
    set -l path_entry (dirname (type -P $rust_binary))
    set -e PATH[(contains -i $path_entry $PATH)]
end

mock rustup \* "echo \"stable-x86_64-unknown-linux-gnu (default)\"; echo \"rustc 1.86.0 (05f9846f8 2025-03-31)\""

set -lx tide_rustc_icon 

_rustc # CHECK:

touch Cargo.toml
_rustc # CHECK:  1.86.0

mock rustc \* "echo 'rustc 1.85.1 (4eb161250 2025-03-15)'"

_rustc # CHECK:  1.85.1
