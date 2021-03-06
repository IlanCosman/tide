# RUN: %fish %s

function _pwd -a dir
    cd $dir
    _tide_decolor (_tide_item_pwd)
end

set COLUMNS 80

# Unwritable directories

sudo mkdir -p ~/unwritable/dir # Uses sudo to make the dir unwritable

set -lx tide_pwd_unwritable_icon ''

_pwd ~/unwritable # CHECK:  ~/unwritable
_pwd ~/unwritable/dir # CHECK:  ~/unwritable/dir

# No icon / directories

set -lx tide_pwd_unwritable_icon

_pwd / # CHECK: /
_pwd /usr # CHECK: /usr
_pwd /usr/share # CHECK: /usr/share

# Normal directories

mkdir -p ~/normal/dir

_pwd ~ # CHECK: ~
_pwd ~/normal # CHECK: ~/normal
_pwd ~/normal/dir # CHECK: ~/normal/dir

rm -rf ~/normal

# Long directories

set -l longDir ~/alfa/bravo/charlie/delta/echo/foxtrot/golf/hotel/india/juliett/kilo/lima/mike/november/oscar/papa
mkdir -p $longDir
_pwd "$longDir" # CHECK: ~/a/b/c/d/e/f/g/hotel/india/juliett/kilo/lima/mike/november/oscar/papa

# Truncate to unique
mkdir -p ~/alfa/bratwurst
_pwd "$longDir" # CHECK: ~/a/brav/c/d/e/f/g/h/india/juliett/kilo/lima/mike/november/oscar/papa
rm -r ~/alfa/bratwurst

# Markers
mkdir -p ~/alfa/.git
_pwd "$longDir" # CHECK: ~/alfa/b/c/d/e/f/g/h/india/juliett/kilo/lima/mike/november/oscar/papa

rm -r ~/alfa
