# RUN: %fish %s
_tide_parent_dirs

function _deno
    _tide_decolor (_tide_item_deno)
end

set -l tmpdir (mktemp -d)
cd $tmpdir

mock deno --version "echo deno 2.1.2 (stable, release, x86_64-unknown-linux-gnu)
v8 13.0.245.12-rusty
typescript 5.6.2
"
set -lx tide_deno_icon 

_deno # CHECK:

touch deno.json
_deno # CHECK:  2.1.2

command rm -r $tmpdir
