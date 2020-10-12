@mesg '-------rust--------'

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
@test 'rs file' (_rust) = " 1.30.0-beta"
rm blah.rs

@test 'Nothing' -z (_rust)

touch Cargo.toml
set -lx tide_rust_verbose_version false
@test 'Cargo.toml no suffix' (_rust) = " 1.30.0"

rm -r $rustDir