# RUN: %fish %s
_tide_parent_dirs

function _pwd -a dir
    mkdir -p $dir
    cd $dir
    source (functions --details _tide_pwd) # Recache stuff
    _tide_decolor (_tide_pwd)
end

set -l tmpdir (mktemp -d)
set -lx HOME $tmpdir
set -lx COLUMNS 80
set -lx dist_btwn_sides 80
set -l longDir alfa/bravo/charlie/delta/echo/foxtrot/golf/hotel/india/juliett/kilo/lima/mike/november/oscar/papa

# ------------------------------------ICONS-----------------------------------
set -lx tide_pwd_icon_unwritable unwritable_icon
set -lx tide_pwd_icon_home home_icon
set -lx tide_pwd_icon normal_icon

# ------------------Starts with slash------------------
_pwd / # CHECK: unwritable_icon /
_pwd /tmp # CHECK: normal_icon /tmp
_pwd /tmp/foo # CHECK: normal_icon /tmp/foo

# ----------Truncation----------
_pwd /tmp/$longDir # CHECK: normal_icon /t/a/b/c/d/e/f/g/h/india/juliett/kilo/lima/mike/november/oscar/papa

mkdir -p /tmp/alfa/bratwurst
_pwd /tmp/$longDir # CHECK: normal_icon /t/a/brav/c/d/e/f/g/h/i/juliett/kilo/lima/mike/november/oscar/papa
command rm -r /tmp/alfa/bratwurst

mkdir -p /tmp/alfa/bravohello
_pwd /tmp/$longDir # CHECK: normal_icon /t/a/bravo/c/d/e/f/g/h/i/juliett/kilo/lima/mike/november/oscar/papa
command rm -r /tmp/alfa/bravohello

mkdir -p /tmp/.git
_pwd /tmp/$longDir # CHECK: normal_icon /tmp/a/b/c/d/e/f/g/h/i/juliett/kilo/lima/mike/november/oscar/papa
command rm -r /tmp/.git

# ------------------Starts with home------------------
_pwd $tmpdir/ # CHECK: home_icon ~
_pwd $tmpdir/tmp # CHECK: normal_icon ~/tmp
_pwd $tmpdir/tmp/foo # CHECK: normal_icon ~/tmp/foo

# ----------Truncation----------
_pwd $tmpdir/tmp/$longDir # CHECK: normal_icon ~/t/a/b/c/d/e/f/g/h/india/juliett/kilo/lima/mike/november/oscar/papa

mkdir -p $tmpdir/tmp/alfa/bratwurst
_pwd $tmpdir/tmp/$longDir # CHECK: normal_icon ~/t/a/brav/c/d/e/f/g/h/i/juliett/kilo/lima/mike/november/oscar/papa
command rm -r $tmpdir/tmp/alfa/bratwurst

mkdir -p $tmpdir/tmp/alfa/bravohello
_pwd $tmpdir/tmp/$longDir # CHECK: normal_icon ~/t/a/bravo/c/d/e/f/g/h/i/juliett/kilo/lima/mike/november/oscar/papa
command rm -r $tmpdir/tmp/alfa/bravohello

mkdir -p $tmpdir/tmp/.git
_pwd $tmpdir/tmp/$longDir # CHECK: normal_icon ~/tmp/a/b/c/d/e/f/g/h/i/juliett/kilo/lima/mike/november/oscar/papa
command rm -r $tmpdir/tmp/.git

# ------------------------------------NO ICONS-----------------------------------
set -lx tide_pwd_icon_unwritable
set -lx tide_pwd_icon_home
set -lx tide_pwd_icon

# ------------------Starts with slash------------------
_pwd / # CHECK: /
_pwd /tmp # CHECK: /tmp
_pwd /tmp/foo # CHECK: /tmp/foo

# ----------Truncation----------
_pwd /tmp/$longDir # CHECK: /t/a/b/c/d/e/foxtrot/golf/hotel/india/juliett/kilo/lima/mike/november/oscar/papa

mkdir -p /tmp/alfa/bratwurst
_pwd /tmp/$longDir # CHECK: /t/a/brav/c/d/e/f/golf/hotel/india/juliett/kilo/lima/mike/november/oscar/papa
command rm -r /tmp/alfa/bratwurst

mkdir -p /tmp/alfa/bravohello
_pwd /tmp/$longDir # CHECK: /t/a/bravo/c/d/e/f/golf/hotel/india/juliett/kilo/lima/mike/november/oscar/papa
command rm -r /tmp/alfa/bravohello

mkdir -p /tmp/.git
_pwd /tmp/$longDir # CHECK: /tmp/a/b/c/d/e/f/golf/hotel/india/juliett/kilo/lima/mike/november/oscar/papa
command rm -r /tmp/.git

# ------------------Starts with home------------------
_pwd $tmpdir/ # CHECK: ~
_pwd $tmpdir/tmp # CHECK: ~/tmp
_pwd $tmpdir/tmp/foo # CHECK: ~/tmp/foo

# ----------Truncation----------
_pwd $tmpdir/tmp/$longDir # CHECK: ~/t/a/b/c/d/e/f/golf/hotel/india/juliett/kilo/lima/mike/november/oscar/papa

mkdir -p $tmpdir/tmp/alfa/bratwurst
_pwd $tmpdir/tmp/$longDir # CHECK: ~/t/a/brav/c/d/e/f/golf/hotel/india/juliett/kilo/lima/mike/november/oscar/papa
command rm -r $tmpdir/tmp/alfa/bratwurst

mkdir -p $tmpdir/tmp/alfa/bravohello
_pwd $tmpdir/tmp/$longDir # CHECK: ~/t/a/bravo/c/d/e/f/golf/hotel/india/juliett/kilo/lima/mike/november/oscar/papa
command rm -r $tmpdir/tmp/alfa/bravohello

mkdir -p $tmpdir/tmp/.git
_pwd $tmpdir/tmp/$longDir # CHECK: ~/tmp/a/b/c/d/e/f/golf/hotel/india/juliett/kilo/lima/mike/november/oscar/papa
command rm -r $tmpdir/tmp/.git

# ------------------------------------Weird Directories------------------------------------
mkdir -p "$tmpdir/tmp/has spaces/foo"
_pwd "$tmpdir/tmp/has spaces/foo" # CHECK: ~/tmp/has spaces/foo

mkdir -p "$tmpdir/tmp/--has dashes/foo"
_pwd "$tmpdir/tmp/--has dashes/foo" # CHECK: ~/tmp/--has dashes/foo

mkdir -p "$tmpdir/tmp/has'quotes''/foo"
_pwd "$tmpdir/tmp/has'quotes''/foo" # CHECK: ~/tmp/has'quotes''/foo

# ---------- Truncation with a dot directory ----------
set -l longDirWithDot .zulu/bravo/charlie/delta/echo/foxtrot/golf/hotel/india/juliett/kilo/lima/mike/november/oscar/papa
_pwd $tmpdir/tmp/$longDirWithDot # CHECK: ~/t/.z/b/c/d/e/f/golf/hotel/india/juliett/kilo/lima/mike/november/oscar/papa

mkdir -p $tmpdir/tmp/.zumwalt
_pwd $tmpdir/tmp/$longDirWithDot # CHECK: ~/t/.zul/b/c/d/e/f/golf/hotel/india/juliett/kilo/lima/mike/november/oscar/papa
command rm -r $tmpdir/tmp/.zumwalt

# ---------- Truncation with a regex-unfriendly character ----------
set -l longDirWithDot "[testing]/bravo/charlie/delta/echo/foxtrot/golf/hotel/india/juliett/kilo/lima/mike/november/oscar/papa"
_pwd $tmpdir/tmp/$longDirWithDot # CHECK: ~/t/[/b/c/d/e/f/golf/hotel/india/juliett/kilo/lima/mike/november/oscar/papa

mkdir -p "$tmpdir/tmp/[hello"
_pwd $tmpdir/tmp/$longDirWithDot # CHECK: ~/t/[t/b/c/d/e/f/golf/hotel/india/juliett/kilo/lima/mike/november/oscar/papa
command rm -r "$tmpdir/tmp/[hello"

# ------------------------------------Cleanup------------------------------------
command rm -r $tmpdir
