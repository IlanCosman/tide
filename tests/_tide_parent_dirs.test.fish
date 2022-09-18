# RUN: %fish %s
_tide_parent_dirs

function _parent_dirs -a dir
    cd $dir
    eval "set _tide_parent_dirs $_tide_parent_dirs"
    path is $_tide_parent_dirs/test.foo && echo found
end

set -l tmpdir (mktemp -d)

mkdir -p "$tmpdir/tmp/has spaces/foo"
_parent_dirs "$tmpdir/tmp/has spaces/foo" # CHECK:
touch "$tmpdir/tmp/has spaces/test.foo"
_parent_dirs "$tmpdir/tmp/has spaces/foo" # CHECK: found

mkdir -p "$tmpdir/tmp/--has dashes/foo"
_parent_dirs "$tmpdir/tmp/--has dashes/foo" # CHECK:
touch "$tmpdir/tmp/--has dashes/test.foo"
_parent_dirs "$tmpdir/tmp/--has dashes/foo" # CHECK: found

mkdir -p "$tmpdir/tmp/has'quotes''/foo"
_parent_dirs "$tmpdir/tmp/has'quotes''/foo" # CHECK:
touch "$tmpdir/tmp/has'quotes''/test.foo"
_parent_dirs "$tmpdir/tmp/has'quotes''/foo" # CHECK: found

command rm -r $tmpdir
