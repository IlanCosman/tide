# RUN: %fish %s

set -l tmpdir (mktemp -d)

function _pwd -a dir --inherit-variable tmpdir
    cd $dir
    HOME=$tmpdir _tide_decolor (_tide_pwd)
end

set -g COLUMNS 80
set -g dist_btwn_sides 80

# Unwritable directories

mkdir -p $tmpdir/unwritable/dir
chmod -R -w $tmpdir/unwritable # revoke write access

set -lx tide_pwd_icon_unwritable ''

_pwd $tmpdir/unwritable # CHECK:  ~/unwritable
_pwd $tmpdir/unwritable/dir # CHECK:  ~/unwritable/dir

chmod -R +w $tmpdir/unwritable # grant write access

# No icon / directories

set -lx tide_pwd_icon_unwritable

_pwd / # CHECK: /
_pwd /usr # CHECK: /usr
_pwd /usr/share # CHECK: /usr/share

# Normal directories

mkdir -p $tmpdir/normal/dir

_pwd $tmpdir # CHECK: ~
_pwd $tmpdir/normal # CHECK: ~/normal
_pwd $tmpdir/normal/dir # CHECK: ~/normal/dir

# Long directories

set -l longDir $tmpdir/alfa/bravo/charlie/delta/echo/foxtrot/golf/hotel/india/juliett/kilo/lima/mike/november/oscar/papa
mkdir -p $longDir
_pwd "$longDir" # CHECK: ~/a/b/c/d/e/foxtrot/golf/hotel/india/juliett/kilo/lima/mike/november/oscar/papa

# Truncate to unique
mkdir -p $tmpdir/alfa/bratwurst
_pwd "$longDir" # CHECK: ~/a/brav/c/d/e/f/golf/hotel/india/juliett/kilo/lima/mike/november/oscar/papa
rm -r $tmpdir/alfa/bratwurst

# Markers
mkdir -p $tmpdir/alfa/.git
_pwd "$longDir" # CHECK: ~/alfa/b/c/d/e/f/golf/hotel/india/juliett/kilo/lima/mike/november/oscar/papa

rm -r $tmpdir
