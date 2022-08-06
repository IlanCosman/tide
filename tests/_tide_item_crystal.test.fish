# RUN: %fish %s

function _crystal
    _tide_decolor (_tide_item_crystal)
end

set -l crystal_directory (mktemp -d)
cd $crystal_directory

mock crystal --version "echo 'Crystal 1.5.0 (2022-07-06)

LLVM: 14.0.6
Default target: aarch64-apple-darwin21.5.0'"

set -lx tide_crystal_icon ⬢

_crystal # CHECK:

touch shard.yml

_crystal # CHECK: ⬢ 1.5.0

rm -r $crystal_directory
